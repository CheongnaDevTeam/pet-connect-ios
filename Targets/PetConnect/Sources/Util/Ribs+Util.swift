//
//  Ribs+Util.swift
//  PetConnect
//
//  Created by 이원빈 on 10/25/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import UIKit
import RIBs

public final class NavigationControllerable: ViewControllable {
  
  public var uiviewController: UIViewController { self.navigationController }
  public let navigationController: UINavigationController
  
  public init(root: ViewControllable) {
    let navigation = UINavigationController(rootViewController: root.uiviewController)
    navigation.navigationBar.isTranslucent = false
    navigation.navigationBar.backgroundColor = .white
    navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance
    
    self.navigationController = navigation
  }
}

public extension ViewControllable {
  
  func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
    self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
  }
  
  func presentOverVeritcally(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
    viewControllable.uiviewController.modalPresentationStyle = .overCurrentContext
    viewControllable.uiviewController.modalTransitionStyle = .coverVertical
    self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
  }
  
  func presentFullScreen(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
    viewControllable.uiviewController.modalPresentationStyle = .fullScreen
    DispatchQueue.main.async {
      self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }
  }
  
  func dismiss(completion: (() -> Void)?) {
    self.uiviewController.dismiss(animated: true, completion: completion)
  }
  
  func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.pushViewController(viewControllable.uiviewController, animated: animated)
    } else {
      self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
    }
  }
  
  func popViewController(animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.popViewController(animated: animated)
    } else {
      self.uiviewController.navigationController?.popViewController(animated: animated)
    }
  }
    
    func popToViewController(_ viewController: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToViewController(viewController.uiviewController, animated: animated)
        } else {
            self.uiviewController.navigationController?.popToViewController(viewController.uiviewController, animated: animated)
        }
    }
  
  func popToRoot(animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.popToRootViewController(animated: animated)
    } else {
      self.uiviewController.navigationController?.popToRootViewController(animated: animated)
    }
  }
  
  func setViewControllers(_ viewControllerables: [ViewControllable]) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
    } else {
      self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
    }
  }
  
  var topViewControllable: ViewControllable {
    var top: ViewControllable = self
    
    while let presented = top.uiviewController.presentedViewController as? ViewControllable {
      top = presented
    }
    
    return top
  }
}

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { self }
    
    convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
