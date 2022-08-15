//
//  UICollectionView + Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

extension UICollectionView {
    
    func register(_ someObject: AnyClass) {
        self.register(UINib(nibName: "\(someObject.self)", bundle: .main), forCellWithReuseIdentifier: "\(someObject.self)")
    }
}
