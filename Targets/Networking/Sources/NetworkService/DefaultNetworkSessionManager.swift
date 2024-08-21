//
//  DefaultNetworkSessionManager.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import Combine
import NetworkingInterface

public class DefaultNetworkSessionManager: NetworkSessionManager {
  
  public init() {}
  
  public func request(_ request: URLRequest) -> AnyPublisher<NetworkingOutput, URLError> {
    return URLSession.shared.dataTaskPublisher(for: request).eraseToAnyPublisher()
  }
}
