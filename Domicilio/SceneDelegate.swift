import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let homePage = HomePage()
        let rootController = UINavigationController(rootViewController: homePage)
        window?.rootViewController = rootController
        
        window?.makeKeyAndVisible()
    }
}
