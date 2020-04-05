import UIKit

protocol HomeViewDelegate {
    func didLoad()
}

class HomePage: UIViewController {
    var delegate: HomeViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.didLoad()
    }
    
    
    func update(_ model: HomeViewState) {
        navigationItem.title = model.title
    }
}
