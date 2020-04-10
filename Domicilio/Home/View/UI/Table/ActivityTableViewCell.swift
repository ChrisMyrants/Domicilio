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
    
    @IBOutlet weak var mail1Button: UIButton! {
        didSet {
            UIButton.toMailButton(from: mail1Button)
        }
    }
    
    @IBOutlet weak var mail2Button: UIButton! {
        didSet {
            UIButton.toMailButton(from: mail2Button)
        }
    }
    
    @IBOutlet weak var mail3Button: UIButton! {
        didSet {
            UIButton.toMailButton(from: mail3Button)
        }
    }
    
    @IBOutlet weak var site1Button: UIButton! {
        didSet {
            UIButton.toSiteButton(from: site1Button)
        }
    }
    
    @IBOutlet weak var site2Button: UIButton!  {
           didSet {
               UIButton.toSiteButton(from: site2Button)
           }
       }
    
    @IBOutlet weak var site3Button: UIButton! {
           didSet {
               UIButton.toSiteButton(from: site3Button)
           }
       }
}

extension ActivityTableViewCell {
    func update(_ model: HomeViewState.Activity) {
        nameLabel.text = model.name
    }
}


