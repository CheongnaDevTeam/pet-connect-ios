//
//  Font+.swift
//  DesignSystem
//
//  Created by 이원빈 on 10/26/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

public extension UIFont {
  static func w100(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.thin.font(size: size)
  }
  static func w200(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.extraLight.font(size: size)
  }
  static func w300(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.light.font(size: size)
  }
  static func w400(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.regular.font(size: size)
  }
  static func w500(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.medium.font(size: size)
  }
  static func w600(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.semiBold.font(size: size)
  }
  static func w700(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.bold.font(size: size)
  }
  static func w800(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.extraBold.font(size: size)
  }
  static func w900(size: CGFloat) -> UIFont {
    return DesignSystemFontFamily.Pretendard.black.font(size: size)
  }
}
