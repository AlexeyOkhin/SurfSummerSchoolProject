//
//  UITextField + Extensions.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 17.08.2022.
//

import UIKit

//MARK: - Extension for add left padding fof text in textfield

extension UITextField {
    func leftPadding(size:CGFloat) {
       self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
       self.leftViewMode = .always
   }
}
