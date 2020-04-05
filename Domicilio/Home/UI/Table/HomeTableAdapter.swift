import UIKit

final class HomeTableAdapter: NSObject {
    var viewState: [HomeViewState.Grouping]?
    weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            // TODO: Register cell with identifier "activityTableViewCell"
            tableView?.reloadData()
        }
    }
}

extension HomeTableAdapter {
    func update(_ model: [HomeViewState.Grouping]) {
        viewState = model
        tableView?.reloadData()
    }
}

extension HomeTableAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewState?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewState?[section].activities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }
}
