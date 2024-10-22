//
//  BaseViewController.swift
//  PetConnect
//
//  Created by 이원빈 on 10/22/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

class BaseViewController<T: Reactor>: UIViewController, View {
  // MARK: Properties
  var disposeBag = DisposeBag()
  
  var reactor: T? {
    didSet {
      if let reactor = reactor {
        self.bind(reactor: reactor)
      }
    }
  }
  
  // MARK: Initializers
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewHierarchy()
    self.setupViewLayout()
    self.setupInitialView()
  }
  
  // MARK: Methods
  func bind(reactor: T) {
    
  }
  
  /// addSubView() 를 통해 하위 뷰를 추가합니다.
  func setupViewHierarchy() {
    
  }
  
  /// 뷰간 제약을 설정합니다.
  func setupViewLayout() {
    
  }
  
  final func setupInitialView() {
    view.backgroundColor = .systemBackground
  }
}
