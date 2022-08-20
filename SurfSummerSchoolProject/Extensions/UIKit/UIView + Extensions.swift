//
//  UIView + Extensions.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 20.08.2022.
//

import UIKit


//MARK: - Activity Indicator

extension UIImageView {
    
  func startAnimationLoading() {
    let rotation = CABasicAnimation(keyPath: "transform.rotation")
    self.isHidden = false
    rotation.fromValue = 0
    rotation.toValue = 2 * Double.pi
    rotation.duration = 0.7
    rotation.repeatCount = 100
    rotation.isRemovedOnCompletion = false
    layer.add(rotation, forKey: "spin")
    rotation.isRemovedOnCompletion = false
  }

  func stopAnimationLoading() {
    self.isHidden = true
    layer.removeAllAnimations()
  }
}
