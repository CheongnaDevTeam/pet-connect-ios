//
//  PetConnectApp.swift
//  PetConnect
//
//  Created by 이원빈 on 8/13/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct PetConnectApp: App {
  @UIApplicationDelegateAdaptor var delegate: AppDelegate
  
  static let store = Store(initialState: LoginFeature.State()) {
    LoginFeature()
//      ._printChanges()
  }
  
  init() {
    guard let infoPlist = Bundle.main.infoDictionary,
          let kakaoAppKey = infoPlist["KAKAO_NATIVE_APP_KEY"],
          let appKey = kakaoAppKey as? String else { return }
    KakaoSDK.initSDK(appKey: appKey)
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        LoginView(store: PetConnectApp.store)
          .onOpenURL(perform: { url in
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
              AuthController.handleOpenUrl(url: url)
            }
          })
      }
    }
  }
}
