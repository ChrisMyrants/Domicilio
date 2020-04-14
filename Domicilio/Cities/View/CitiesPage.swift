import UIKit

protocol CitiesViewDelegate {
    func didLoad()
    func retry()
}

class CitiesPage: UIViewController {

    var delegate: CitiesViewDelegate?
    private var adapter = CitiesTableAdapter()
    
    // MARK: IBOutlet
    @IBOutlet weak var successStackView: UIStackView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            adapter.tableView = tableView
        }
    }
    
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
    func update(_ model: CitiesViewState) {
        switch model {
        case let .successful(cities):
            successStackView.isHidden = false
            welcomeLabel.text = "Benvenuto in Domicilio!"
            descriptionLabel.text = "Seleziona la tua città per scoprire quali sono le attività che offrono servizi a domicilio"
            adapter.update(cities.cities)
            
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
