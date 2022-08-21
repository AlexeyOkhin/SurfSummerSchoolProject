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
        static let serchColor = UIColor(rgb: 0xF5F5F5)
        static let dateText = UIColor(rgb: 0xB3B3B3)
        static let placeholderSearch = UIColor(rgb: 0xBEBEBE)
        static let errorNavBar = UIColor(rgb: 0xF35858)
        static let textField = UIColor(rgb: 0xFBFBFB)
        static let deviderTF = UIColor(rgb: 0xDFDFDF)
        static let placeHolderTF = UIColor(rgb: 0xB3B3B3)
        static let errorLabel = UIColor(rgb: 0xFF002E)
        static let appBlack = UIColor.black
        static let appWhite = UIColor.white
    }
}
