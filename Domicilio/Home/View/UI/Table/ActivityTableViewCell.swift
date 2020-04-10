import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tel1Button: UIButton! {
        didSet {
            UIButton.toTelephoneButton(from: tel1Button)
        }
    }
    @IBOutlet weak var tel2Button: UIButton!{
        didSet {
            UIButton.toTelephoneButton(from: tel2Button)
        }
    }
    @IBOutlet weak var tel3Button: UIButton!{
        didSet {
            UIButton.toTelephoneButton(from: tel3Button)
        }
    }
    
    @IBOutlet weak var mail1Button: UIButton!
    @IBOutlet weak var mail2Button: UIButton!
    @IBOutlet weak var mail3Button: UIButton!
    
    @IBOutlet weak var site1Button: UIButton!
    @IBOutlet weak var site2Button: UIButton!
    @IBOutlet weak var site3Button: UIButton!
}

extension ActivityTableViewCell {
    func update(_ model: HomeViewState.Activity) {
        nameLabel.text = model.name
    }
}

extension UIButton {
    static func toTelephoneButton(from button: UIButton) {
        button.backgroundColor = .green
        button.setTitle("📞", for: .normal)
        button.layer.cornerRadius = 10
    }
}
