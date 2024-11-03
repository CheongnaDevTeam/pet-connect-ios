//
//  DefaultLoginRepository.swift
//  PetConnect
//
//  Created by 이원빈 on 10/26/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import AuthenticationServices

import RxSwift
import RxKakaoSDKUser
import KakaoSDKUser
import KakaoSDKAuth

final class DefaultLoginRepository: LoginRepository {
  
  private let appleLoginManager: AppleLoginManager
  
  init(appleLoginManager: AppleLoginManager) {
    self.appleLoginManager = appleLoginManager
  }
  
  func requestLoginWithApple() -> Observable<String> {
    let request = Observable<String>.just("")
      .withUnretained(self)
      .flatMap { owner, _ in
        owner.appleLoginManager.signInWithApple()
        return Observable<String>.empty()
      }
    let parse = appleLoginManager.authorizationRelay
      .withUnretained(self)
      .map { owner, authorization in
        owner.parseJWT(from: authorization)
      }
    return .merge([request, parse])
    
  }
  
  func requestLoginWithKakao() -> RxSwift.Observable<String> {
    let isInstalledKakaoTalk: Bool = UserApi.isKakaoTalkLoginAvailable()
    let loginReqeust: Observable<OAuthToken> = (
      isInstalledKakaoTalk ? UserApi.shared.rx.loginWithKakaoTalk() : UserApi.shared.rx.loginWithKakaoAccount()
    )
    
    return loginReqeust.map(\.accessToken)
  }
  
  func parseJWT(from authorization: ASAuthorization) -> String {
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
      guard let jwtData = appleIDCredential.identityToken,
            let jwtString = String(data: jwtData, encoding: .utf8) else {
        return "NULL"
      }
      return jwtString
    case let passwordCredential as ASPasswordCredential:
      let userIdentifier = passwordCredential.user
      return userIdentifier
    default:
      return "NULL"
    }
  }
}
