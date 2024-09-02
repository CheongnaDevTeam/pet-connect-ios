//
//  SocialLoginClient.swift
//  PetConnect
//
//  Created by 이원빈 on 9/2/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import AuthenticationServices
import Foundation
import Combine

import ComposableArchitecture
import KakaoSDKUser
import KakaoSDKAuth

struct SocialLoginClient {
  private let appleLoginManager = AppleLoginManager()
  private var cancelBag = Set<AnyCancellable>()
  
  @MainActor
  func requestWithKakao() async throws -> OAuthToken? {
    try await withCheckedThrowingContinuation { continuation in
      if UserApi.isKakaoTalkLoginAvailable() {
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
          if let error = error {
            continuation.resume(throwing: error)
          } else {
            continuation.resume(returning: oauthToken)
          }
        }
      } else {
        UserApi.shared.loginWithKakaoAccount() { oauthToken, error in
          if let error = error {
            continuation.resume(throwing: error)
          } else {
            continuation.resume(returning: oauthToken)
          }
        }
      }
    }
  }
  
  @MainActor
  func requestWithApple() async throws -> String {
    let asauthorization = try await appleLoginManager.signInWithApple()
    
    if let appleIDCredential = asauthorization.credential as? ASAuthorizationAppleIDCredential {
      let userId = appleIDCredential.user // jwt
      let fullName = appleIDCredential.fullName
      let email = appleIDCredential.email
      print("userID:\(userId) fullName:\(fullName) email:\(email)")
      return userId
    } else {
      return "NULL"
    }
  }
}

enum ASError: Error {
  case unknown
}
extension SocialLoginClient: DependencyKey {
  static let liveValue = Self()
}

extension DependencyValues {
  var socialLogin: SocialLoginClient {
    get { self[SocialLoginClient.self] }
    set { self[SocialLoginClient.self] = newValue }
  }
}
