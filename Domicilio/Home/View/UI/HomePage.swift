import UIKit

protocol HomeViewDelegate {
    func didLoad()
}

class HomePage: UIViewController {
    var delegate: HomeViewDelegate!
    private lazy var adapter = HomeTableAdapter(controller: self)
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            adapter.tableView = tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.didLoad()
    }
    
    
    func update(_ model: HomeViewState) {
        navigationItem.title = model.title
        adapter.update(model.groupedActivities)
    }
}
