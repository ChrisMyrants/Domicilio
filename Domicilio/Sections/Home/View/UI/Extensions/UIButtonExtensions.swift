import UIKit

extension UIColor {
    enum Domicilio {
        static let green = UIColor(red: 171/255, green: 227/255, blue: 184/255, alpha: 1.0)
        static let blue = UIColor(red: 156/255, green: 204/255, blue: 240/255, alpha: 1.0)
        static let yellow = UIColor(red: 245/255, green: 212/255, blue: 150/255, alpha: 1.0)
    }
}

extension UIButton {
    static func toTelephoneButton(from button: UIButton) {
        button.backgroundColor = UIColor.Domicilio.green
        button.setTitle("📞", for: .normal)
        button.layer.cornerRadius = 10
    }
    
    static func toMailButton(from button: UIButton) {
        button.backgroundColor = UIColor.Domicilio.blue
        button.setTitle("✉️", for: .normal)
        button.layer.cornerRadius = 10
    }
    
    static func toSiteButton(from button: UIButton) {
        button.backgroundColor = UIColor.Domicilio.yellow
        button.setTitle("🌐", for: .normal)
        button.layer.cornerRadius = 10
    }
}
