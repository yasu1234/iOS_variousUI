import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    static let shared = SceneDelegate()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window = window
        
        // this is the way how to use UIStoryboard class
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        window.rootViewController = vc
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

extension SceneDelegate {
    func showMainContent() {
        let controller = MainTabBarController()
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

