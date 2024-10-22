//
//  LoginViewController.swift
//  PetConnect
//
//  Created by 이원빈 on 10/22/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

final class LoginViewController: BaseViewController<LoginReactor> {

  // MARK: UI
  private let appleLoginButton: UIButton = {
    let button = UIButton()
    button.setTitle("애플로그인", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    return button
  }()
  
  private let kakaoLoginButton: UIButton = {
    let button = UIButton()
    button.setTitle("카카오로그인", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    return button
  }()
  
  private let loadingIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.style = .large
    view.color = .green
    return view
  }()
  
  // MARK: Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    self.reactor = LoginReactor()
  }
  
  override func bind(reactor: LoginReactor) {
    super.bind(reactor: reactor)
    bindAction(reactor: reactor)
    bindState(reactor: reactor)
  }
  
  override func setupViewHierarchy() {
    super.setupViewHierarchy()
    makeViewHierarchy()
  }
  
  override func setupViewLayout() {
    super.setupViewLayout()
    makeViewLayout()
  }
}

// MARK: - Bind
private extension LoginViewController {
  typealias Action = LoginReactor.Action
  typealias State = LoginReactor.State
  
  func bindAction(reactor: LoginReactor) {
    kakaoLoginButton.rx.tap
      .asSignal()
      .map { Action.kakaoLoginButtonTapped }
      .emit(to: reactor.action)
      .disposed(by: disposeBag)
    
    appleLoginButton.rx.tap
      .asSignal()
      .map { Action.appleLoginButtonTapped }
      .emit(to: reactor.action)
      .disposed(by: disposeBag)
  }
  
  func bindState(reactor: LoginReactor) {
    reactor.state
      .map(\.isLoading)
      .distinctUntilChanged()
      .asSignal(onErrorJustReturn: false)
      .emit(to: loadingIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }
}

// MARK: - View Layout
private extension LoginViewController {
  
  func makeViewHierarchy() {
    view.addSubview(appleLoginButton)
    view.addSubview(kakaoLoginButton)
    view.addSubview(loadingIndicator)
  }
  
  func makeViewLayout() {
    appleLoginButton.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    kakaoLoginButton.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalTo(appleLoginButton.snp.bottom).offset(30)
    }
    loadingIndicator.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
