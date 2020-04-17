import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    static let identifier = "FilterCollectionViewCell"
    
    // MARK: IBOutlet
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 88.0/255.0 , green: 153.0/255.0 , blue: 219.0/255.0, alpha: 1.0).cgColor
        }
    }
}

extension FilterCollectionViewCell {
    func update(_ model: HomeViewState.Successful.Filter) {
        button.setTitle(model.icon + " " + model.name, for: .normal)
    }
}
