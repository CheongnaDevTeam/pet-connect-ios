//
//  LoginBuilder.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RIBs

protocol LoginDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class LoginComponent: Component<LoginDependency> {
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
  fileprivate let appleLoginManager = AppleLoginManager()
  fileprivate var loginRepository: LoginRepository {
    DefaultLoginRepository(appleLoginManager: appleLoginManager)
  }
  fileprivate var loginUsecase: LoginUsecase {
    DefaultLoginUsecase(loginRepository: loginRepository)
  }
}

extension LoginComponent: OnboardingDependency {
  
}

// MARK: - Builder

protocol LoginBuildable: Buildable {
  func build(withListener listener: LoginListener) -> LoginRouting
}

final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {
  
  override init(dependency: LoginDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: LoginListener) -> LoginRouting {
    let component = LoginComponent(dependency: dependency)
    let viewController = LoginViewController()
    let interactor = LoginInteractor(
      presenter: viewController,
      initialState: .init(),
      loginUsecase: component.loginUsecase
    )
    interactor.listener = listener
    
    let onboardingBuilder = OnboardingBuilder(dependency: component)
    
    return LoginRouter(
      interactor: interactor,
      viewController: viewController,
      onboardingBuilder: onboardingBuilder)
  }
}
