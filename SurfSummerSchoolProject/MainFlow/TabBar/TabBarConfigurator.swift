//
//  TabBarConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class TabBarConfigurator {
    
    //MARK: - Private property
    
    private let allTab: [TabBarModel] = [.main, .favorite, .profile]
    
    //MARK: - Internal func
    
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

//MARK: - Private method

private extension TabBarConfigurator {
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getControllers()
        return tabBarController
    }
    
    func getControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let tabBarItem = UITabBarItem(title: tab.properties.title, image: tab.properties.image, selectedImage: tab.properties.image)
            controller.tabBarItem = tabBarItem
            viewControllers.append(controller)
        }
        
        return viewControllers
    }
    
    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return generationNavigationController(for: MainViewController())
        case .favorite:
            return generationNavigationController(for: FavoriteViewController())
        case .profile:
            return ProfileViewController()
        }
    }
    
    func generationNavigationController(for rootViewController: UIViewController) -> UIViewController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.navigationBar.backgroundColor = .white
        return navigation
    }
}
