//
//  RootBuilder.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

extension RootComponent: LoginDependency {
  
}

// MARK: - Builder

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
  
  override init(dependency: RootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> LaunchRouting {
    let component = RootComponent(dependency: dependency)
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)
    
    let loginBuilder = LoginBuilder(dependency: component)
    
    return RootRouter(
      interactor: interactor,
      viewController: viewController,
      loginBuilder: loginBuilder
    )
  }
}
