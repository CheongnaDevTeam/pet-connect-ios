//
//  AppleLoginManager.swift
//  PetConnect
//
//  Created by 이원빈 on 9/2/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import AuthenticationServices

import Combine

public final class AppleLoginManager: NSObject {
  public var continuation: CheckedContinuation<ASAuthorization, Error>?
  
  public func signInWithApple() async throws -> ASAuthorization {
    return try await withCheckedThrowingContinuation { continuation in
      self.continuation = continuation
      let request = ASAuthorizationAppleIDProvider().createRequest()
      request.requestedScopes = [.fullName, .email]
      
      let controller = ASAuthorizationController(authorizationRequests: [request])
      controller.delegate = self
      controller.presentationContextProvider = self
      controller.performRequests()
    }
  }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    continuation?.resume(returning: authorization)
    continuation = nil
  }
  
  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: Error
  ) {
    continuation?.resume(throwing: error)
    continuation = nil
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
