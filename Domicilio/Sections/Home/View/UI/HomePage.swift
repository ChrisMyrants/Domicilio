import UIKit

protocol HomeViewDelegate {
    func didLoad()
    func retry()
    func openCities()
}

class HomePage: UIViewController {
    var delegate: HomeViewDelegate!
    private lazy var adapter = HomeTableAdapter(controller: self)
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            adapter.tableView = tableView
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
            
            tableView.isHidden = false
            adapter.update(value.filteredGroupedActivities)
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
            failureView.isHidden = true
            
        case .isLoading:
            navigationItem.title = nil
            tableView.isHidden = true
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            failureView.isHidden = true
        
        case let .failed(message):
            navigationItem.title = nil
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
