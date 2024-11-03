//
//  AppleLoginManager.swift
//  PetConnect
//
//  Created by 이원빈 on 9/2/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import AuthenticationServices

import RxSwift

public final class AppleLoginManager: NSObject {
  public var authorizationRelay: PublishSubject<ASAuthorization> = .init()
  
  public func signInWithApple() {
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self
    controller.presentationContextProvider = self
    controller.performRequests()
  }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    authorizationRelay.onNext(authorization)
  }
  
  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: Error
  ) {
    authorizationRelay.onError(error)
  }
}

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
  public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let firstKeyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
      return firstKeyWindow
    } else {
      return .init()
    }
  }
}
