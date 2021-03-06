import UIKit

final class FiltersCollectionAdapter: NSObject {
    weak var controller: HomePage!
    
    init(controller: HomePage) {
        self.controller = controller
    }
    
    private var collectionLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return layout
    }
    
    weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
            collectionView?.collectionViewLayout = collectionLayout
            
            collectionView?.register(
                UINib(nibName: "FilterCollectionViewCell", bundle: nil),
                forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
            
            collectionView?.showsHorizontalScrollIndicator = false
            
            collectionView?.reloadData()
        }
    }
    
    private var filters: [HomeViewState.Successful.Filter]?
}

extension FiltersCollectionAdapter {
    func update(_ model: [HomeViewState.Successful.Filter]) {
        guard
            let oldFilters = filters,
            oldFilters.count == model.count
            else {
                self.filters = model
                collectionView?.reloadData()
                return
        }
        
        let indexes = Array(0...(model.count - 1))
        let coupledModels = zip(oldFilters, model).map { $0 }
        let changedFiltersIndexes = zip(coupledModels, indexes)
            .filter {
                let (tuple, _) = $0
                let (old, new) = tuple
                return (old == new).not }
            .map { $0.1 }
            .map { IndexPath(item: $0, section: 0) }
        
        filters = model
        
        collectionView?.reloadItems(at: changedFiltersIndexes)
    }
    
    func select(filter: HomeViewState.Successful.Filter) {
        controller.select(filter: filter)
    }
}

extension FiltersCollectionAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.map(\.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell
            else { fatalError("Can't have no FilterCollectionViewCell here") }
        
        cell.update(filters![indexPath.row])
        cell.selectFilter = select(filter:)
        
        return cell
    }
}

extension FiltersCollectionAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentFilter = filters![indexPath.row]
        
        // really, I have no idea why I need to add some many spaces to make this work
        let text = currentFilter.icon + "                 " + currentFilter.name
        
        return CGSize(width: text.size(withAttributes: nil).width,
                      height: 30)
    }
}
