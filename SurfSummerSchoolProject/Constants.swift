//
//  Constants.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 04.08.2022.
//

import UIKit
struct Constants {
    
    //MARK: -  Images
    struct Image {
        static let launchSurf = UIImage(named: "launchSurf") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let mainTabBar = UIImage(named: "mainTabBar") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let favoriteTabBar = UIImage(named: "favoriteTabBar") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let profileTabBar = UIImage(named: "profileTabBar") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let searchNavBar = UIImage(named: "searchNavBar") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let favoriteFalse = UIImage(named: "favoriteFalse") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let favoriteTrue = UIImage(named: "favoriteTrue") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let testKogi = UIImage(named: "testKorgi") ?? UIImage(systemName: "questionmark.app.dashed")!
    }
    
    //MARK: - Size for item collectionView
    struct Size {
        static let horisontalInset: CGFloat = 16
        static let spacBetweenRows: CGFloat = 8
        static let spaceBetweenElements: CGFloat = 8
    }
}
