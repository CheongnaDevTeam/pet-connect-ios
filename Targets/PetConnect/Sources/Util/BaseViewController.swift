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

class BaseViewController: UIViewController {
  // MARK: Properties
  var disposeBag = DisposeBag()
  
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
    self.setupView()
    self.setupInitialDisplay()
  }
  
  // MARK: Methods
  func setupView() {}
  
  final func setupInitialDisplay() {
    view.backgroundColor = .systemBackground
    navigationController?.isNavigationBarHidden = true
  }
}
