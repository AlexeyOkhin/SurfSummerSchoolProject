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
        static let arrowLeft = UIImage(named: "arrowLeft") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let magnifire = UIImage(named: "magnifire") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let emptyMain = UIImage(named: "emptyMain") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let surfAuthBackground = UIImage(named: "surfAuthBackground") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let loadingIndicator = UIImage(named: "loadingIndicator") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let openEye = UIImage(named: "openEye") ?? UIImage(systemName: "questionmark.app.dashed")!
        static let closeEye = UIImage(named: "closeEye") ?? UIImage(systemName: "questionmark.app.dashed")!
    }
    
    //MARK: - Size for item collectionView
    
    struct Size {
        static let horisontalInset: CGFloat = 16
        static let favoriteSpacBetweenRows: CGFloat = 24
        static let spacBetweenRows: CGFloat = 8
        static let spaceBetweenElements: CGFloat = 8
        static let aspectRatioMain: CGFloat = 1.46
        static let aspectRatioFavarite: CGFloat = 1.16
    }
    
    //MARK: - Colors
    
    struct Color {
        static let serchColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        static let dateText = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        static let placeholderSearch = #colorLiteral(red: 0.7438805699, green: 0.7438805699, blue: 0.7438805699, alpha: 1)
        static let errorNavBar = #colorLiteral(red: 0.9714686275, green: 0.4395110607, blue: 0.4181905985, alpha: 1)
        static let textField = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        static let deviderTF = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        static let placeHolderTF = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        static let errorLabel = #colorLiteral(red: 1, green: 0, blue: 0.1803921569, alpha: 1)
        
        
    }
}
