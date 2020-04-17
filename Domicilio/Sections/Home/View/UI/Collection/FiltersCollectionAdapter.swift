import UIKit

final class FiltersCollectionAdapter: NSObject {
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    private var collectionLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = CGSize(width: 0, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return layout
    }
    
    weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
            
            collectionView?.showsHorizontalScrollIndicator = false
            
            collectionView?.register(
                UINib(nibName: "FilterCollectionViewCell", bundle: nil),
                forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
            collectionView?.collectionViewLayout = collectionLayout
            collectionView?.reloadData()
        }
    }
    
    private var filters: [HomeViewState.Successful.Filter]?
}

extension FiltersCollectionAdapter {
    func update(_ model: [HomeViewState.Successful.Filter]) {
        filters = model
        collectionView?.reloadData()
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
        
        return cell
    }
}

extension FiltersCollectionAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentFilter = filters![indexPath.row]
        let text = currentFilter.icon + "                 " + currentFilter.name // really, I have no idea why I need to add some many spaces to make this work
        
        return CGSize(width: text.size(withAttributes: nil).width,
                      height: 30)
    }
}
