import UIKit

protocol HomeViewDelegate {
    func didLoad()
}

class HomePage: UIViewController {
    var delegate: HomeViewDelegate!
    private lazy var adapter = HomeTableAdapter(controller: self)
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            adapter.tableView = tableView
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.didLoad()
    }
    
    
    func update(_ model: HomeViewState) {
        switch model {
        case let .successful(value):
            navigationItem.title = value.title
            
            tableView.isHidden = false
            adapter.update(value.groupedActivities)
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
        case .isLoading:
            tableView.isHidden = true
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        default:
            return
        }
    }
}
