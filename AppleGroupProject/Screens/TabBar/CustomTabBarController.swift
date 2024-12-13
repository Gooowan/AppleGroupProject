//
//  CustomTabBarController.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 11.12.2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private enum ControllerType: Int {
        case quoteListController = 0
        case searchController
        case accountController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGray
        UITabBar.appearance().unselectedItemTintColor = .systemGray3
        UITabBar.appearance().backgroundColor = ThemeColor.background
        
        viewControllers = [
            createVC(type: .quoteListController, title: "Quotes", systemImageName: "list.dash"),
            createVC(type: .searchController, title: "Search", systemImageName: "magnifyingglass"),
            createVC(type: .accountController, title: "Account", systemImageName: "person.crop.circle")
        ]
    }
    
    private func createVC(type: ControllerType, title: String, systemImageName: String) -> UINavigationController {
        let controller: UIViewController
        switch type {
        case .quoteListController:
            controller = QuoteListController()
        case .searchController:
            controller = SearchController()
        case .accountController:
            controller = AccountController()
        }
        
        controller.title = title
        controller.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: systemImageName),
            tag: type.rawValue)
        
        return UINavigationController(rootViewController: controller)
    }
}
