import UIKit

protocol HomeViewDelegate {
    func didLoad()
    func retry()
    func openCities()
    func select(filter: HomeViewState.Successful.Filter)
}

class HomePage: UIViewController {
    var delegate: HomeViewDelegate!
    private lazy var collectionAdapter = FiltersCollectionAdapter(controller: self)
    private lazy var tableAdapter = HomeTableAdapter(controller: self)
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionAdapter.collectionView = collectionView
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableAdapter.tableView = tableView
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var failureView: UIStackView!
    @IBOutlet weak var failureMessage: UILabel!
    
    // MARK: IBActions
    @IBAction func didTapRiprova(_ sender: Any) {
        delegate.retry()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.didLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "cityIcon"),
            style: .plain,
            target: self,
            action: #selector(openCities))
    }
    
    
    func update(_ model: HomeViewState) {
        switch model {
        case let .successful(value):
            navigationItem.title = value.title
            
            collectionView.isHidden = false
            collectionAdapter.update(value.filters)
            tableView.isHidden = false
            tableAdapter.update(value.filteredGroupedActivities)
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
            failureView.isHidden = true
            
        case .isLoading:
            navigationItem.title = nil
            
            collectionView.isHidden = true
            tableView.isHidden = true
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            failureView.isHidden = true
        
        case let .failed(message):
            navigationItem.title = nil
            
            collectionView.isHidden = true
            tableView.isHidden = true
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
            failureView.isHidden = false
            failureMessage.text = message
        }
    }
}

fileprivate extension HomePage {
    @objc func openCities() {
        delegate.openCities()
    }
}

extension HomePage {
    func select(filter: HomeViewState.Successful.Filter) {
        delegate.select(filter: filter)
    }
}
