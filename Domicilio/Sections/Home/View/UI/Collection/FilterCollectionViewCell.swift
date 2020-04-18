import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    static let identifier = "FilterCollectionViewCell"
    static let blue = UIColor(red: 88.0/255.0 , green: 153.0/255.0 , blue: 219.0/255.0, alpha: 1.0)
    
    private var isFilterSelected: Bool = false {
        didSet {
            if isFilterSelected {
                button.backgroundColor = FilterCollectionViewCell.blue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.darkGray, for: .normal)
            }
        }
    }
    
    var model: HomeViewState.Successful.Filter?
    var selectFilter: ((HomeViewState.Successful.Filter) -> ())?
    
    // MARK: IBOutlets
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.borderColor = FilterCollectionViewCell.blue.cgColor
        }
    }
    
    // MARK: IBActions
    @IBAction func didTapButton(_ sender: UIButton) {
        guard
            let model = model,
            let selectFilter = selectFilter
            else { return }
        
        selectFilter(model)
    }
}

extension FilterCollectionViewCell {
    func update(_ model: HomeViewState.Successful.Filter) {
        self.model = model
        
        button.setTitle(model.icon + " " + model.name, for: .normal)
        isFilterSelected = model.selected
    }
}
