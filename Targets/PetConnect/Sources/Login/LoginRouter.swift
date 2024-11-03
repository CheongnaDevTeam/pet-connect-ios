//
//  LoginRouter.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RIBs

protocol LoginInteractable: Interactable, OnboardingListener {
  var router: LoginRouting? { get set }
  var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoginRouter: ViewableRouter<LoginInteractable,
                         LoginViewControllable>,
                         LoginRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  
  private let onboardingBuilder: OnboardingBuildable
  private var onboardingRouter: ViewableRouting?
  
  init(
    interactor: LoginInteractable,
    viewController: LoginViewControllable,
    onboardingBuilder: OnboardingBuildable
  ) {
    self.onboardingBuilder = onboardingBuilder
    
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachOnboarding() {
    guard self.onboardingRouter == nil else { return }
    let router = onboardingBuilder.build(
      withListener: interactor
    )
    self.onboardingRouter = router
    attachChild(router)
    viewController.pushViewController(router.viewControllable, animated: true)
  }
  
  func detachOnboarding() {
    guard let router = self.onboardingRouter else {
      return
    }
    detachChild(router)
    onboardingRouter = nil
    viewController.popViewController(animated: true)
  }
}
