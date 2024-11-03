//
//  LoginUsecase.swift
//  PetConnect
//
//  Created by 이원빈 on 10/26/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RxSwift

protocol LoginUsecase {
  func loginWithApple() -> Observable<String>
  func loginWithKakao() -> Observable<String>
}

final class DefaultLoginUsecase: LoginUsecase {
  
  private let loginRepository: LoginRepository
  
  init(loginRepository: LoginRepository) {
    self.loginRepository = loginRepository
  }
  
  func loginWithApple() -> Observable<String> {
    loginRepository.requestLoginWithApple()
  }
  
  func loginWithKakao() -> RxSwift.Observable<String> {
    loginRepository.requestLoginWithKakao()
  }
}
