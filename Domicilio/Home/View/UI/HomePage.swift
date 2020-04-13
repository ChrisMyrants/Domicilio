import UIKit

protocol HomeViewDelegate {
    func didLoad()
    func retry()
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
    @IBOutlet weak var failureView: UIStackView!
    
    @IBAction func didTapRiprova(_ sender: Any) {
        delegate.retry()
    }
    
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
            
            failureView.isHidden = true
            
        case .isLoading:
            tableView.isHidden = true
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            failureView.isHidden = true
        
        case .failed:
            tableView.isHidden = true
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
            failureView.isHidden = false
        }
    }
}
