//
//  LoginViewController.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import DesignSystem

import RIBs
import RxSwift
import RxCocoa
import SnapKit

final class LoginViewController: BaseViewController, LoginPresentable, LoginViewControllable {
  
  // MARK: Properties
  weak var listener: LoginPresentableListener?
  private let actionRelay = PublishRelay<LoginPresentableListener.Action>()
  
  // MARK: UI Component
  private let appleLoginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .gray_900
    button.layer.cornerRadius = 28
    button.titleLabel?.font = .w600(size: 16)
    button.setTitle("Apple로 시작하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  private let kakaoLoginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor(hex: 0xFEE500)
    button.layer.cornerRadius = 28
    button.titleLabel?.font = .w600(size: 16)
    button.setTitle("카카오로 시작하기", for: .normal)
    button.setTitleColor(.gray_900, for: .normal)
    let icon = DesignSystemAsset.kakaoLogo.image
    let resizedIcon = icon.resized(to: .init(width: 24, height: 24))
    button.setImage(resizedIcon, for: .normal)
    button.imageEdgeInsets.right = 8
    return button
  }()
  
  private let nextButton: UIButton = {
    let button = UIButton()
    button.setTitle("다음", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    return button
  }()
  
  private let tokenLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray_500
    label.numberOfLines = 0
    return label
  }()
  
  private let loadingIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.style = .large
    view.color = .gray_900
    return view
  }()
  
  // MARK: Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    bind(listener: self.listener)
  }
  
  override func setupView() {
    super.setupView()
    configureViewHierarchy()
    configureViewLayout()
  }
}

// MARK: - Bind listener
extension LoginViewController {
  
  private func bind(listener: LoginPresentableListener?) {
    guard let listener = listener else { return }
    self.bindActionRelay()
    bindAction()
    bindState(from: listener)
  }
  
  private func bindActionRelay() {
    self.actionRelay.asObservable()
      .bind(with: self) { onwer, action in
        onwer.listener?.sendAction(action)
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind Action
private extension LoginViewController {
  typealias Action = LoginPresentableAction
  
  func bindAction() {
    bindKakaoLoginButton()
    bindAppleLoginButton()
    // TESET
    nextButton.rx.tap
      .asSignal()
      .map { Action.nextButtonTapped }
      .emit(to: actionRelay)
      .disposed(by: disposeBag)
  }
  
  func bindKakaoLoginButton() {
    kakaoLoginButton.rx.tap
      .asSignal()
      .map { Action.kakaoLoginButtonTapped }
      .emit(to: actionRelay)
      .disposed(by: disposeBag)
  }
  
  func bindAppleLoginButton() {
    appleLoginButton.rx.tap
      .asSignal()
      .map { Action.appleLoginButtonTapped }
      .emit(to: actionRelay)
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State
private extension LoginViewController {
  
  func bindState(from listener: LoginPresentableListener) {
    bindIsLoadingState(from: listener)
    bindTokenState(from: listener)
  }
  
  func bindIsLoadingState(from listener: LoginPresentableListener) {
    listener.state
      .map(\.isLoading)
      .distinctUntilChanged()
      .asSignal(onErrorJustReturn: false)
      .emit(to: loadingIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }
  
  func bindTokenState(from listener: LoginPresentableListener) {
    listener.state
      .map(\.token)
      .distinctUntilChanged()
      .asSignal(onErrorJustReturn: "")
      .emit(to: tokenLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

// MARK: - Setup View
private extension LoginViewController {
  
  func configureViewHierarchy() {
    view.addSubview(appleLoginButton)
    view.addSubview(kakaoLoginButton)
    view.addSubview(tokenLabel)
    view.addSubview(loadingIndicator)
    view.addSubview(nextButton)
  }
  
  func configureViewLayout() {
    appleLoginButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.height.equalTo(56)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    kakaoLoginButton.snp.makeConstraints{
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.height.equalTo(56)
      $0.bottom.equalTo(appleLoginButton.snp.top).offset(-8)
    }
    tokenLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(view.snp.centerY)
    }
    loadingIndicator.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    nextButton.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
