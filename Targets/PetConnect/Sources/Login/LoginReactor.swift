//
//  LoginReactor.swift
//  PetConnect
//
//  Created by 이원빈 on 10/22/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import ReactorKit
import RxSwift

final class LoginReactor: Reactor {
  
  enum Action {
    case appleLoginButtonTapped
    case kakaoLoginButtonTapped
  }
  
  enum Mutation {
    case setLoading(Bool)
    case setToken(String)
  }
  
  struct State {
    var isLoading: Bool = false
    var token: String = ""
  }
  
  let initialState = State()
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .appleLoginButtonTapped: return requestAppleLogin()
    case .kakaoLoginButtonTapped: return requestKakaoLogin()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setLoading(let bool):
      newState.isLoading = bool
    case .setToken(let token):
      newState.token = token
    }
    return newState
  }
}

// MARK: - Mutation

private extension LoginReactor {
  
  func requestAppleLogin() -> Observable<Mutation> {
    print("애플로그인")

    let process: Observable<Mutation> = Observable<Int>
      .timer(.seconds(2), scheduler: MainScheduler.instance)
      .flatMap { _ in Observable<Mutation>.empty() }
      
    let sequence: [Observable<Mutation>] = [
      .just(.setLoading(true)),
      process,
      .just(.setLoading(false))
    ]
    return .concat(sequence)
  }
  
  func requestKakaoLogin() -> Observable<Mutation> {
    print("카카오로그인")
    return .empty()
  }
}
