//
//  Preview.swift
//  DesignSystem
//
//  Created by 이원빈 on 11/3/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

#if canImport(SwiftUI) && DEBUG

import SwiftUI

public extension UIViewController {
  private struct Preview: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> some UIViewController {
      return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
      //
    }
  }
  
  var preview: some View {
    return Preview(viewController: self)
  }
  
  func showPreview(_ deviceType: Preview_DeviceType) -> some View {
    preview
      .previewDevice(PreviewDevice(rawValue: deviceType.rawValue))
      .previewDisplayName(deviceType.rawValue)
  }
}

public extension UIView {
  private struct Preview: UIViewRepresentable {
    let view: UIView
    
    func makeUIView(context: Context) -> some UIView {
      return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
      //
    }
  }
  
  var preview: some View {
    return Preview(view: self)
  }
  
  func showPreview(_ deviceType: Preview_DeviceType) -> some View {
    preview
      .previewDevice(PreviewDevice(rawValue: deviceType.rawValue))
      .previewDisplayName(deviceType.rawValue)
  }
}

#endif

public enum Preview_DeviceType: String, CaseIterable {
  case iPhone_8_Plus = "iPhone 8 Plus"
  case iPhone_12 = "iPhone 12"
  case iPhone_13_Pro_Max = "iPhone 13 Pro Max"
  case iPhone_15 = "iPhone 15"
  case iPhone_15_Pro = "iPhone 15 Pro"
  case iPhone_SE_3rd_generation = "iPhone SE (3nd generation)"
}
