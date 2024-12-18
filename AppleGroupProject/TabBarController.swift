import UIKit

class MainTabBarController: UITabBarController {
    
    private var likedImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = ThemeColor.thirdColor
        
        let homeScreenVC = UINavigationController(rootViewController: HomeScreenViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        homeScreenVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )
        
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        
        viewControllers = [homeScreenVC, searchVC, profileVC]
    }
}
