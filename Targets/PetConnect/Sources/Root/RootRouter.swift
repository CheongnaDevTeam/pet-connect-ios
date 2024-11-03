//
//  RootRouter.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, LoginListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  private let loginBuilder: LoginBuildable
  private var loginRouting: ViewableRouting?
  
  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    loginBuilder: LoginBuildable
  ) {
    self.loginBuilder = loginBuilder
    
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: - RootRouting
  func attachLogin() {
    if loginRouting != nil {
      return
    }
    let loginRouter = loginBuilder.build(withListener: interactor)

    viewController.presentFullScreen(
      UINavigationController(root: loginRouter.viewControllable),
      animated: false,
      completion: nil
    )
    attachChild(loginRouter)
    loginRouting = loginRouter
  }
  
  func detachLogin() {
    if let loginRouter = loginRouting {
      viewController.popViewController(animated: true)
      detachChild(loginRouter)
      loginRouting = nil
    }
  }
}
