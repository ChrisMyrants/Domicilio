import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var homePresenter: HomePresenter!
    var citiesPresenter: CitiesPresenter!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let homePage = HomePage()
        let citiesPage = CitiesPage()
        let rootController = UINavigationController(rootViewController: citiesPage)
        
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        homePresenter = HomePresenter(rootNavigationController: rootController, homePage: homePage, networkingService: NetworkingService())
        citiesPresenter = CitiesPresenter(rootNavigationController: rootController, citiesPage: citiesPage, networkingService: NetworkingService())
    }
}
