import UIKit

final class CitiesTableAdapter: NSObject {
    weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
            tableView?.reloadData()
        }
    }
    var cities: [CitiesViewState.Cities.City] = []
}

extension CitiesTableAdapter {
    func update(_ model: [CitiesViewState.Cities.City]) {
        cities = model
        tableView?.reloadData()
    }
}

// MARK: UITableViewDataSource
extension CitiesTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath)
        let city = cities[indexPath.row]
        
        cell.textLabel?.text = city.name
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension CitiesTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
