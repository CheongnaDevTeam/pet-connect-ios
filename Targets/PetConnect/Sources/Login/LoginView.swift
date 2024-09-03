//
//  LoginView.swift
//  PetConnect
//
//  Created by 이원빈 on 8/30/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import SwiftUI
import DesignSystem

import ComposableArchitecture
import AuthenticationServices

struct LoginView: View {
  let store: StoreOf<LoginFeature>
  
  var body: some View {
    VStack {
      Spacer()
      kakaoLoginButton
      appleLoginButton
    }
  }
  
  var kakaoLoginButton: some View {
    Button {
      store.send(.kakaoLoginButtonTapped)
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .foregroundColor(.yellow)
          .frame(width: 300, height: 45)
        Text("카카오 로그인")
          .foregroundColor(.black)
      }
    }
  }
  
  var appleLoginButton: some View {
    Button {
      store.send(.appleLoginButtonTapped)
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .foregroundColor(.black)
          .frame(width: 300, height: 45)
        Text("애플 로그인")
          .foregroundColor(.white)
      }
    }
  }
}

#Preview {
  LoginView(store: .init(initialState: LoginFeature.State(), reducer: {
    LoginFeature()
  }))
}
