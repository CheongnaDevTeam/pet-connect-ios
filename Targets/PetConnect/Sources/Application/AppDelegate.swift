//
//  AppDelegate.swift
//  PetConnect
//
//  Created by 이원빈 on 8/13/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

import KakaoSDKAuth
import RxKakaoSDKCommon
import RxKakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    setupKakaoSDK()
    return true
  }
  
  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
    return UISceneConfiguration(name: "Default Configuration",
                                sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication,
                   didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

private extension AppDelegate {
  
  func setupKakaoSDK() {
    guard let infoDictionary = Bundle.main.infoDictionary,
          let kakaoAppKey = infoDictionary["KAKAO_NATIVE_APP_KEY"],
          let appKey = kakaoAppKey as? String else {
      return
    }
    
    RxKakaoSDK.initSDK(appKey: appKey)
  }
}
