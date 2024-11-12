//
//  UIButton+.swift
//  DesignSystem
//
//  Created by 이원빈 on 11/3/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

public extension UIButton {
  func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
    
    UIGraphicsBeginImageContext(minimumSize)
    defer { UIGraphicsEndImageContext() }
    
    color.setFill()
    UIRectFill(CGRect(origin: .zero, size: minimumSize))
    
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    setBackgroundImage(colorImage, for: state)
  }
}
