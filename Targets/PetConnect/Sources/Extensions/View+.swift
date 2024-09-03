//
//  View+.swift
//  PetConnect
//
//  Created by 이원빈 on 9/3/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import SwiftUI

// MARK: - View Debugging
extension View {
  
  func debug(_ color: Color = .blue, alignment: Alignment = .topTrailing, particularSize: FrameInfo.Size? = nil) -> some View {
    modifier(FrameInfo(color: color, alignment: alignment, size: particularSize))
  }
}

struct FrameInfo: ViewModifier {
  
  enum Size: String {
    case width
    case height
  }
  
  let color: Color
  let alignment: Alignment
  let size: Size?
  
  func body(content: Content) -> some View {
    content
      #if DEBUG
      .overlay(GeometryReader(content: overlay))
      #endif
  }
  
  func overlay(for geometry: GeometryProxy) -> some View {
    ZStack(alignment: alignment) {
      
      Rectangle()
        .strokeBorder(style: .init(lineWidth: 1, dash: [3]))
        .foregroundColor(color)
      if let size = size {
        Text("\(size.rawValue): \(size == .width ? geometry.size.width : geometry.size.height)")
          .font(.caption2)
          .minimumScaleFactor(0.5)
          .foregroundColor(color)
          .offset(y: alignment == .topTrailing ? -20 : 0)
          .offset(y: alignment == .topLeading ? -20 : 0)
          .offset(y: alignment == .bottomTrailing ? 20 : 0)
          .offset(y: alignment == .bottomLeading ? 20 : 0)
      } else {
        Text("(\(Int(geometry.frame(in: .global).origin.x)), \(Int(geometry.frame(in: .global).origin.y))) \(Int(geometry.size.width))x\(Int(geometry.size.height))")
          .font(.caption2)
          .minimumScaleFactor(0.5)
          .foregroundColor(color)
          .offset(y: alignment == .topTrailing ? -20 : 0)
          .offset(y: alignment == .topLeading ? -20 : 0)
          .offset(y: alignment == .bottomTrailing ? 20 : 0)
          .offset(y: alignment == .bottomLeading ? 20 : 0)
      }
    }
    
  }
}
