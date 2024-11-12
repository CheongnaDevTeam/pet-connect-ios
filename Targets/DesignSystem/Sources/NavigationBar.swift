//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by 이원빈 on 11/3/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

public final class NavigationBar: UIView {
  public let dismissRelay: PublishRelay<Void> = .init()
  private var disposeBag = DisposeBag()
  
  private let leftButton: UIButton = {
    let button = UIButton()
    let icon = DesignSystemAsset.chevronLeft.image.resized(to: .init(width: 24, height: 24))
    button.setImage(icon, for: .normal)
    return button
  }()
  
  private let title: UILabel = {
    let label = UILabel()
    label.font = .w600(size: 18)
    label.textColor = .gray_900
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    configureViewHierarchy()
    configureViewLayout()
    bindView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func setTitle(_ title: String) {
    self.title.text = title
  }
  
  private func bindView() {
    leftButton.rx.tap
      .asSignal()
      .emit(to: dismissRelay)
      .disposed(by: disposeBag)
  }
}

private extension NavigationBar {
  
  func configureViewHierarchy() {
    self.addSubview(leftButton)
    self.addSubview(title)
  }
  
  func configureViewLayout() {
    self.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width)
      $0.height.equalTo(56)
    }
    leftButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(48)
      $0.leading.equalTo(self.snp.leading).inset(4)
    }
    title.snp.makeConstraints{
      $0.center.equalToSuperview()
    }
  }
}
