//
//  UILabel + Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 11.08.2022.
//

import UIKit

extension UILabel {
    convenience init(name: String?, font: UIFont? = .systemFont(ofSize: 14)) {
        self.init()
        self.text = name
        self.font = font
    }
    
}
