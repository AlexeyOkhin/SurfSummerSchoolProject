//
//  UIView + Extensions.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 20.08.2022.
//

import UIKit


//MARK: - Activity Indicator

public extension UIImageView {
    
  func startAnimationLoading(duration: Float) {
    let rotation = CABasicAnimation(keyPath: "transform.rotation")
    rotation.fromValue = 0
    rotation.toValue = 2 * Double.pi
    rotation.duration = 0.7
    rotation.repeatCount = duration
    rotation.isRemovedOnCompletion = false
    layer.add(rotation, forKey: "spin")
  }

  func stopAnimationLoading() {
    layer.removeAllAnimations()
  }
}
