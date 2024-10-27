//
//  UIColor+.swift
//  DesignSystem
//
//  Created by 이원빈 on 9/2/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

public extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: a
    )
  }
  
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    self.init(
      red: (hex >> 16) & 0xFF,
      green: (hex >> 8) & 0xFF,
      blue: hex & 0xFF,
      a: alpha
    )
  }
}

public extension UIColor {
  static let gray_50 = UIColor(hex: 0xEEEEEF)
  static let gray_100 = UIColor(hex: 0xCACACC)
  static let gray_200 = UIColor(hex: 0xB1B1B3)
  static let gray_300 = UIColor(hex: 0x8D8D90)
  static let gray_400 = UIColor(hex: 0x77777B)
  static let gray_500 = UIColor(hex: 0x55555A)
  static let gray_600 = UIColor(hex: 0x4D4D52)
  static let gray_700 = UIColor(hex: 0x3C3C40)
  static let gray_800 = UIColor(hex: 0x2F2F32)
  static let gray_900 = UIColor(hex: 0x242426)
  
  static let orange_50 = UIColor(hex: 0xFFF1EB)
  static let orange_100 = UIColor(hex: 0xFFD2C1)
  static let orange_200 = UIColor(hex: 0xFFBDA3)
  static let orange_300 = UIColor(hex: 0xFF9F78)
  static let orange_400 = UIColor(hex: 0xFF8C5E)
  static let orange_500 = UIColor(hex: 0xFF6F36)
  static let orange_600 = UIColor(hex: 0xE86531)
  static let orange_700 = UIColor(hex: 0xB54F26)
  static let orange_800 = UIColor(hex: 0x8C3D1E)
  static let orange_900 = UIColor(hex: 0x6B2F17)
  
  static let red_light =         UIColor(hex: 0xFEEDED)
  static let red_light_hover =   UIColor(hex: 0xFEE3E3)
  static let red_light_active =  UIColor(hex: 0xFDC6C6)
  static let red_normal =        UIColor(hex: 0xF94646)
  static let red_normal_hover =  UIColor(hex: 0xE03F3F)
  static let red_normal_active = UIColor(hex: 0xC73838)
  static let red_dark =          UIColor(hex: 0xBB3535)
  static let red_dark_hover =    UIColor(hex: 0x952A2A)
  static let red_dark_active =   UIColor(hex: 0x701F1F)
  static let red_darker =        UIColor(hex: 0x571919)
  
  static let green_light =         UIColor(hex: 0xECF9EE)
  static let green_light_hover =   UIColor(hex: 0xE2F6E6)
  static let green_light_active =  UIColor(hex: 0xC4EBCB)
  static let green_normal =        UIColor(hex: 0x40C057)
  static let green_normal_hover =  UIColor(hex: 0x3AAD4E)
  static let green_normal_active = UIColor(hex: 0x339A46)
  static let green_dark =          UIColor(hex: 0x309041)
  static let green_dark_hover =    UIColor(hex: 0x267334)
  static let green_dark_active =   UIColor(hex: 0x1D5627)
  static let green_darker =        UIColor(hex: 0x16431E)
  
  static let blue_light =         UIColor(hex: 0xE6F5FF)
  static let blue_light_hover =   UIColor(hex: 0xD9EFFF)
  static let blue_light_active =  UIColor(hex: 0xB0DEFE)
  static let blue_normal =        UIColor(hex: 0x0096FD)
  static let blue_normal_hover =  UIColor(hex: 0x0087E4)
  static let blue_normal_active = UIColor(hex: 0x0078CA)
  static let blue_dark =          UIColor(hex: 0x0071BE)
  static let blue_dark_hover =    UIColor(hex: 0x005A98)
  static let blue_dark_active =   UIColor(hex: 0x004472)
  static let blue_darker =        UIColor(hex: 0x003559)
}
