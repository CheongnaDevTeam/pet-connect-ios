//
//  UIImage+.swift
//  DesignSystem
//
//  Created by 이원빈 on 10/26/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

public extension UIImage {
  func resized(to size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    defer { UIGraphicsEndImageContext() }
    draw(in: CGRect(origin: .zero, size: size))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
