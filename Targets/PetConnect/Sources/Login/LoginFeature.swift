//
//  LoginFeature.swift
//  PetConnect
//
//  Created by 이원빈 on 8/30/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Combine
import Foundation

import ComposableArchitecture
import KakaoSDKAuth

@Reducer
struct LoginFeature {
  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var cancelBag = Set<AnyCancellable>()
  }
  
  enum Action {
    case kakaoLoginButtonTapped
    case appleLoginButtonTapped
    case fetchKakaoToken(OAuthToken)
    case fetchAppleToken(String)
  }
  
  @Dependency(\.socialLogin) var socialLogin
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .kakaoLoginButtonTapped:
        return .run { send in
          try await send(.fetchKakaoToken(self.socialLogin.requestWithKakao()!))
        }
      case .appleLoginButtonTapped:
        return .run { send in
          try await send(.fetchAppleToken(self.socialLogin.requestWithApple()))
        }
      case let .fetchKakaoToken(token):
        print("oauthToken = \(token)")
        // TODO: 서버로 OAuthToken 보내기
        return .none
      case let .fetchAppleToken(token):
        print(token)
        // TODO: jwt 서버로 보내기
        return .none
      }
    }
  }
  
  func mockKakaoLoginUseCase() -> AnyPublisher<String, Error> {
    return Just<String>("kakao")
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
