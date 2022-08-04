//
//  TabBarModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

enum TabBarModel {
    case main
    case favorite
    case profile
    
    var title: String {
        switch self {
        case .main:
            return "Главная"
        case .favorite:
            return "Избранное"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage {
        switch self {
        case .main:
            return #imageLiteral(resourceName: "mainTabBar")
        case .favorite:
            return #imageLiteral(resourceName: "favoriteTabBar")
        case .profile:
            return #imageLiteral(resourceName: "profileTabBar")
        }
    }
        
    var selectedImage: UIImage {
        return image
    }
}
