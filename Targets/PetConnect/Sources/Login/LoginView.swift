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

struct LoginView: View {
  let store: StoreOf<LoginFeature>
  
  var body: some View {
    VStack {
      Spacer()
      Button {
        store.send(.kakaoLoginButtonTapped)
      } label: {
        Image(asset: DesignSystemAsset.kakaoLoginButton)
      }
      Button {
        store.send(.appleLoginButtonTapped)
      } label: {
        Text("애플 로그인")
      }
    }
  }
}

#Preview {
  LoginView(store: .init(initialState: LoginFeature.State(), reducer: {
    LoginFeature()
  }))
}
