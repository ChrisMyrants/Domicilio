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
        citiesPage.isModalInPresentation = true
        
        let rootController = UINavigationController(rootViewController: homePage)
        
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        homePresenter = HomePresenter(
            rootNavigationController: rootController,
            homePage: homePage,
            networkingService: NetworkingService(),
            showCities: {
                rootController.present(citiesPage, animated: true)
        })
        
        citiesPresenter = CitiesPresenter(
            rootNavigationController: rootController,
            citiesPage: citiesPage,
            networkingService: NetworkingService(),
            selectedCity: { cityName, cityURL in
                self.homePresenter.load(city: cityName, with: cityURL)
        })
    
        guard
            let storedCity = UserDefaults.standard.string(forKey: "city"),
            let storedURL = UserDefaults.standard.url(forKey: "url") else {
                rootController.present(citiesPage, animated: true)
                return
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.01) {
            self.homePresenter.load(city: storedCity, with: storedURL)
        }
    }
}
