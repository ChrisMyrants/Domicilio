import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    var sendEmail: ((String) -> ())?
    private var currentModel: HomeViewState.Successful.Activity?
    
    // MARK: IBOutlet
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
    
    @IBOutlet weak var noteLabel: UILabel!
    
    // MARK: Actions
    @IBAction func didTapTelephone1(_ sender: Any) {
        let optPhoneNumber = currentModel.flatMap { $0.tel?.first }
        guard let phoneNumber = optPhoneNumber else { return }
        
        call(phoneNumber: phoneNumber)
    }
    @IBAction func didTapTelephone2(_ sender: Any) {
        let optPhoneNumber = currentModel.flatMap { $0.tel?.getSafely(index: 1) }
        guard let phoneNumber = optPhoneNumber else { return }
        
        call(phoneNumber: phoneNumber)
    }
    @IBAction func didTapTelephone3(_ sender: Any) {
        let optPhoneNumber = currentModel.flatMap { $0.tel?.getSafely(index: 1) }
        guard let phoneNumber = optPhoneNumber else { return }
        
        call(phoneNumber: phoneNumber)
    }
    
    @IBAction func didTapMail1(_ sender: Any) {
        let optEmail = currentModel.flatMap { $0.mail?.first }
        guard let email = optEmail else { return }
        
        sendEmail?(email)
    }
    @IBAction func didTapMail2(_ sender: Any) {
        let optEmail = currentModel.flatMap { $0.mail?.getSafely(index: 1) }
        guard let email = optEmail else { return }
        
        sendEmail?(email)
    }
    @IBAction func didTapMail3(_ sender: Any) {
        let optEmail = currentModel.flatMap { $0.mail?.getSafely(index: 2) }
        guard let email = optEmail else { return }
        
        sendEmail?(email)
    }
    
    @IBAction func didTapSite1(_ sender: Any) {
        let optSite = currentModel.flatMap { $0.site?.first }
        guard let site = optSite else { return }
        
        guard UIApplication.shared.canOpenURL(site) else {
            let urlString = site.absoluteString
            let completeURL = URL(string: "http://" + urlString)!
            UIApplication.shared.open(completeURL)
            
            return
        }
        
        UIApplication.shared.open(site)
    }
    @IBAction func didTapSite2(_ sender: Any) {
        let optSite = currentModel.flatMap { $0.site?.getSafely(index: 1) }
        guard let site = optSite else { return }
        
        guard UIApplication.shared.canOpenURL(site) else {
            let urlString = site.absoluteString
            let completeURL = URL(string: "http://" + urlString)!
            UIApplication.shared.open(completeURL)
            
            return
        }
        
        UIApplication.shared.open(site)
    }
    @IBAction func didTapSite3(_ sender: Any) {
        let optSite = currentModel.flatMap { $0.site?.getSafely(index: 2) }
        guard let site = optSite else { return }
        
        guard UIApplication.shared.canOpenURL(site) else {
            let urlString = site.absoluteString
            let completeURL = URL(string: "http://" + urlString)!
            UIApplication.shared.open(completeURL)
            
            return
        }
        
        UIApplication.shared.open(site)
    }
}

extension ActivityTableViewCell {
    func update(_ model: HomeViewState.Successful.Activity) {
        currentModel = model
        
        nameLabel.text = model.name
        
        tel1Button.isHidden = model.tel.flatMap { $0.getSafely(index: 0) }.isNil
        tel2Button.isHidden = model.tel.flatMap { $0.getSafely(index: 1) }.isNil
        tel3Button.isHidden = model.tel.flatMap { $0.getSafely(index: 2) }.isNil
        
        mail1Button.isHidden = model.mail.flatMap { $0.getSafely(index: 0) }.isNil
        mail2Button.isHidden = model.mail.flatMap { $0.getSafely(index: 1) }.isNil
        mail3Button.isHidden = model.mail.flatMap { $0.getSafely(index: 2) }.isNil
        
        site1Button.isHidden = model.site.flatMap { $0.getSafely(index: 0) }.isNil
        site2Button.isHidden = model.site.flatMap { $0.getSafely(index: 1) }.isNil
        site3Button.isHidden = model.site.flatMap { $0.getSafely(index: 2) }.isNil
        
        noteLabel.text = model.note
    }
}

fileprivate extension ActivityTableViewCell {
    func call(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(url)
    }
}

