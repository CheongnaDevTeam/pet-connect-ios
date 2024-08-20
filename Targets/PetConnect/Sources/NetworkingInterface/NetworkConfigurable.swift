//
//  NetworkConfigurable.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

public protocol NetworkConfigurable {
  
  var baseURL: URL { get }
  
  var headers: [String: String] { get }
  
  var queryParameters: [String: String] { get }
}
