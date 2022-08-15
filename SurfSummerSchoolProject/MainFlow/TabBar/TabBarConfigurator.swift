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
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            viewControllers.append(controller)
        }
        
        return viewControllers
    }
    
    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return generationNavigationController(for: MainViewController(), title: tab.title)
        case .favorite:
            return generationNavigationController(for: FavoriteViewController(), title: tab.title)
        case .profile:
            return generationNavigationController(for: ProfileViewController(), title: tab.title)
        }
    }
    
    func generationNavigationController(for rootViewController: UIViewController, title: String?) -> UIViewController {
        let navigation = UINavigationController(rootViewController: rootViewController)
//        let barButton = createBarButton(image: Constants.Image.searchNavBar, tintColor: .black)
//        navigation.navigationBar.topItem?.rightBarButtonItem = barButton
        navigation.navigationBar.topItem?.title = title
        navigation.navigationBar.backgroundColor = .white
        return navigation
    }
}
