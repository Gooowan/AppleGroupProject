import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let mainTabBarController = MainTabBarController()
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
        
        setupAppearance()
        
        self.window = window
    }
    
    private func setupAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = ThemeColor.thirdColor
        appearance.titleTextAttributes = [
            .foregroundColor: ThemeColor.thirdColor
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: ThemeColor.thirdColor
        ]
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = ThemeColor.thirdColor
        tabBarAppearance.unselectedItemTintColor = ThemeColor.thirdColor
        
    }
}
