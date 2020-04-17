import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    static let identifier = "FilterCollectionViewCell"
    static let blue = UIColor(red: 88.0/255.0 , green: 153.0/255.0 , blue: 219.0/255.0, alpha: 1.0)
    
    private var isFilterSelected: Bool = false {
        didSet {
            button.isHighlighted = isFilterSelected
            if isFilterSelected {
                button.backgroundColor = FilterCollectionViewCell.blue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.darkGray, for: .normal)
            }
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.borderColor = FilterCollectionViewCell.blue.cgColor
            button.isHighlighted = true
        }
    }
    
    // MARK: IBActions
    @IBAction func didTapButton(_ sender: UIButton) {
        isFilterSelected = !isFilterSelected
    }
}

extension FilterCollectionViewCell {
    func update(_ model: HomeViewState.Successful.Filter) {
        button.setTitle(model.icon + " " + model.name, for: .normal)
        isFilterSelected = model.selected
    }
}