//
//  TabBarModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

enum TabBarModel {
    struct TabProperties {
        let title: String
        let image: UIImage
    }
    case main
    case favorite
    case profile
    
    var properties: TabProperties {
        switch self {
        case .main:
            return TabProperties(title: "Главная", image: Constants.Image.mainTabBar)
        case .favorite:
            return TabProperties(title: "Избранное", image: Constants.Image.favoriteTabBar)
        case .profile:
            return TabProperties(title: "Профиль", image: Constants.Image.profileTabBar)
        }
    }
}

