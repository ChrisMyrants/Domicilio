import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var telephoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var siteButton: UIButton!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBAction func didTapTelephone(_ sender: Any) {
    }
    @IBAction func didTapEmail(_ sender: Any) {
    }
    @IBAction func didTapSite(_ sender: Any) {
    }
}

extension ActivityTableViewCell {
    func update(_ model: HomeViewState.Activity) {
        nameLabel.text = model.name
        
        telephoneButton.titleLabel?.text = model.tel
        emailButton.titleLabel?.text = model.mail
        siteButton.titleLabel?.text = model.site?.absoluteString
        
        noteLabel.text = model.note
    }
}
