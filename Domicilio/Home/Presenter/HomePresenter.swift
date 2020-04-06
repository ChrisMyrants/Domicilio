import UIKit

final class HomePresenter {
    var rootNavigationController: UINavigationController
    var homePage: HomePage
    
    init(rootNavigationController: UINavigationController, homePage: HomePage) {
        self.rootNavigationController = rootNavigationController
        self.homePage = homePage
        
        homePage.delegate = self
    }
}

extension HomePresenter: HomeViewDelegate {
    func didLoad() {
        homePage.update(.test)
    }
}
