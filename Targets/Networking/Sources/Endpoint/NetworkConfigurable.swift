//
//  NetworkConfigurable.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import NetworkingInterface

public struct APIDataNetworkConfig: NetworkConfigurable {
  public let baseURL: URL
  public let headers: [String : String]
  public let queryParameters: [String : String]
  
  public init(
    baseURL: URL,
    headers: [String : String] = [:],
    queryParameters: [String : String] = [:]
  ) {
    self.baseURL = baseURL
    self.headers = headers
    self.queryParameters = queryParameters
  }
}
