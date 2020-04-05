import UIKit

class HomePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func update(_ model: HomeViewState) {
        navigationController?.title = model.title
    }
}
