//
//  AppComponent.swift
//  PetConnect
//
//  Created by 이원빈 on 10/24/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyComponent>, RootDependency {
  
  init() {
    super.init(dependency: EmptyComponent())
  }
}
