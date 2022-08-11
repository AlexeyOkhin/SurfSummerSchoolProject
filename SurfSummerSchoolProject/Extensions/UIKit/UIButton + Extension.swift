//
//  UIButton + Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 11.08.2022.
//

import UIKit

extension UIButton {
    convenience init(
        title: String,
        backgroundCollor: UIColor,
        titleColor: UIColor,
        font: UIFont? = .systemFont(ofSize: 16))
    {
        
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundCollor
        self.titleLabel?.font = font
    }
    
}
