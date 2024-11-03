//
//  LoginInteractor.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RIBs
import ReactorKit
import RxSwift

protocol LoginRouting: ViewableRouting {
  func attachOnboarding()
  func detachOnboarding()
}

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoginListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>,
                             LoginInteractable,
                             LoginPresentableListener,
                             Reactor {
  
  enum Mutation {
    case setLoading(Bool)
    case setToken(String)
    case attachOnboardingRIB
  }
  
  weak var router: LoginRouting?
  weak var listener: LoginListener?
  var initialState: LoginPresentableState
  private let loginUsecase: LoginUsecase
  
  init(
    presenter: LoginPresentable,
    initialState: LoginPresentableState,
    loginUsecase: LoginUsecase
  ) {
    self.initialState = initialState
    self.loginUsecase = loginUsecase
    
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func sendAction(_ action: Action) {
    self.action.onNext(action)
  }
  
  // MARK: - Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .appleLoginButtonTapped: return appleLoginButtonTappedMutation()
    case .kakaoLoginButtonTapped: return kakaoLoginButtonTappedMutation()
    case .nextButtonTapped: return .just(.attachOnboardingRIB)
    }
  }
  
  func appleLoginButtonTappedMutation() -> Observable<Mutation> {
    print("애플로그인")
    let process: Observable<Mutation> = loginUsecase.loginWithApple()
      .map { token in .setToken(token) }
      .take(1)
    
    let sequence: [Observable<Mutation>] = [
      .just(.setLoading(true)),
      process,
      .just(.setLoading(false))
    ]
    return .concat(sequence)
  }
  
  func kakaoLoginButtonTappedMutation() -> Observable<Mutation> {
    print("카카오로그인")
    let process: Observable<Mutation> = loginUsecase.loginWithKakao()
      .map { token in .setToken(token) }
      .take(1)
    let sequence: [Observable<Mutation>] = [
      .just(.setLoading(true)),
      process,
      .just(.setLoading(false))
    ]
    return .concat(sequence)
  }
  
  // MARK: - Transform
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    return mutation
      .withUnretained(self)
      .observe(on: MainScheduler.asyncInstance)
      .flatMap { owner, mutation in
        switch mutation {
        case .attachOnboardingRIB:
          return owner.attachOnboardingRIBTransform()
        default:
          return Observable.just(mutation)
        }
      }
  }
  
  func attachOnboardingRIBTransform() -> Observable<Mutation> {
    self.router?.attachOnboarding()
    return .empty()
  }
  
  // MARK: - Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setLoading(let bool): newState.isLoading = bool
    case .setToken(let token):  newState.token = token
    default:
      print("routing mutation")
    }
    return newState
  }
  
  // MARK: - OnboardingListener
  func detachOnboarding() {
    self.router?.detachOnboarding()
  }
}
