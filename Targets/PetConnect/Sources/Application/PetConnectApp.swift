//
//  PetConnectApp.swift
//  PetConnect
//
//  Created by 이원빈 on 8/13/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import SwiftUI

@main
struct PetConnectApp: App {
  @UIApplicationDelegateAdaptor var delegate: AppDelegate
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        HomeView()
      }
    }
  }
}
