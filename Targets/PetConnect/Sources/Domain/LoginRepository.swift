//
//  LoginRepository.swift
//  PetConnect
//
//  Created by 이원빈 on 10/26/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RxSwift

protocol LoginRepository {
  func requestLoginWithApple() -> Observable<String>
  func requestLoginWithKakao() -> Observable<String> 
}
