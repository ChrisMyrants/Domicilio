import UIKit

protocol CitiesViewDelegate {
    func didLoad()
    func retry()
}

class CitiesPage: UIViewController {

    var delegate: CitiesViewDelegate?
    
    // MARK: IBOutlet
    @IBOutlet weak var successStackView: UIStackView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var failureStackView: UIStackView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func didTapRiprova(_ sender: Any) {
        delegate?.retry()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.didLoad()
    }
}

extension CitiesPage {
    func update(from model: CitiesViewState) {
        switch model {
        case let .successful(cities):
            successStackView.isHidden = false
            
            failureStackView.isHidden = true
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        
        case .failure:
            successStackView.isHidden = true
            
            failureStackView.isHidden = false
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        
        case .isLoading:
            successStackView.isHidden = true
            
            failureStackView.isHidden = true
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }
}
