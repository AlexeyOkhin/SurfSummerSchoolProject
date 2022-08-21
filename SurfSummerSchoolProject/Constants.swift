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
        static let launchSurf = UIImage(named: "launchSurf")!
        static let mainTabBar = UIImage(named: "mainTabBar")!
        static let favoriteTabBar = UIImage(named: "favoriteTabBar")!
        static let profileTabBar = UIImage(named: "profileTabBar")!
        static let searchNavBar = UIImage(named: "searchNavBar")!
        static let favoriteFalse = UIImage(named: "favoriteFalse")!
        static let favoriteTrue = UIImage(named: "favoriteTrue")!
        static let testKogi = UIImage(named: "testKorgi")!
        static let arrowLeft = UIImage(named: "arrowLeft")!
        static let magnifire = UIImage(named: "magnifire")!
        static let emptyMain = UIImage(named: "emptyMain")!
        static let surfAuthBackground = UIImage(named: "surfAuthBackground")!
        static let loadingIndicator = UIImage(named: "loadingIndicator")!
        static let openEye = UIImage(systemName: "eye")!
        static let closeEye = UIImage(systemName: "eye.slash")!
    }
    
    //MARK: - Size for items
    
    struct Size {
        static let horisontalInset: CGFloat = 16
        static let favoriteSpacBetweenRows: CGFloat = 24
        static let spacBetweenRows: CGFloat = 8
        static let spaceBetweenElements: CGFloat = 8
        static let aspectRatioMain: CGFloat = 1.46
        static let aspectRatioFavarite: CGFloat = 1.16
        static let contentShiftNormal: CGFloat = 55
        static let contentShiftUp: CGFloat = 35
        static let labelMoveUpConstraint: CGFloat = 2
        static let labelMoveDownConstraint: CGFloat = 18
        
    }
    
    //MARK: - Colors
    
    struct Color {
        static let serchColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        static let dateText = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        static let placeholderSearch = #colorLiteral(red: 0.7438805699, green: 0.7438805699, blue: 0.7438805699, alpha: 1)
        static let errorNavBar = #colorLiteral(red: 0.9529411765, green: 0.3450980392, blue: 0.3450980392, alpha: 1)
        static let textField = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        static let deviderTF = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        static let placeHolderTF = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        static let errorLabel = #colorLiteral(red: 1, green: 0, blue: 0.1803921569, alpha: 1)
        
    }
}
