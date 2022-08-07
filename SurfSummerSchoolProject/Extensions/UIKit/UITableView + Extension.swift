//
//  UITableView + Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

extension UITableView {
    func register(_ someObject: AnyClass) {
        self.register(UINib(nibName: "\(someObject.self)", bundle: .main), forCellReuseIdentifier: "\(someObject.self)")
    }
}
