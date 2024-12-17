import UIKit

class MainTabBarController: UITabBarController {
    
    private var likedImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeScreenVC = UINavigationController(rootViewController: HomeScreenViewController())
        let searchVC = SearchViewController()
        let settingsVC = SettingsViewController()
        
        homeScreenVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 2)
        
        viewControllers = [homeScreenVC, searchVC, settingsVC]
    }
}
