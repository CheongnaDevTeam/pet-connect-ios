//
//  LoginStateAction.swift
//  PetConnect
//
//  Created by 이원빈 on 10/26/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RxSwift

struct LoginPresentableState {
  var isLoading: Bool = false
  var token: String = ""
}

enum LoginPresentableAction {
  case appleLoginButtonTapped
  case kakaoLoginButtonTapped
  case nextButtonTapped // test
}

protocol LoginPresentableListener: AnyObject {
  typealias Action = LoginPresentableAction
  typealias State = LoginPresentableState
  
  func sendAction(_ action: Action)
  var state: Observable<State> { get }
  var currentState: State { get }
}
