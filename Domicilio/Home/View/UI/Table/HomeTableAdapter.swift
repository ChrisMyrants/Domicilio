import UIKit
import MessageUI

final class HomeTableAdapter: NSObject {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    var viewState: [HomeViewState.Grouping]?
    
    weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.register(
                UINib(nibName: "ActivityTableViewCell", bundle: nil),
            forCellReuseIdentifier: "activityTableViewCell")
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

// MARK: UITableViewDataSource
extension HomeTableAdapter: UITableViewDataSource {
    // Headers and sections
    func numberOfSections(in tableView: UITableView) -> Int {
        viewState?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let group = viewState?[section] else { fatalError("Can't have an out of index here") }
        return group.icon + " " + group.name
    }
    
    // Cells and rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewState?[section].activities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let activity = viewState?[indexPath.section].activities[indexPath.row] else {
            fatalError("Can't have an out of index here")
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "activityTableViewCell") as? ActivityTableViewCell else {
            let cell = ActivityTableViewCell()
            cell.update(activity)
            return cell
        }
        
        cell.update(activity)
        cell.sendEmail = sendEmail(to:)
        return cell
    }
}

// MARK: UITableViewDelegate
extension HomeTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: MFMailComposeViewControllerDelegate
extension HomeTableAdapter: MFMailComposeViewControllerDelegate {
    // TODO: continue from here https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email
    func sendEmail(to email: String) {
        guard
            let controller = controller,
            MFMailComposeViewController.canSendMail()
            else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([email])
        
        controller.present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
