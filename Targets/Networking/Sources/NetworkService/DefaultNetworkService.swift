//
//  DefaultNetworkService.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import Combine
import NetworkingInterface

public final class DefaultNetworkService: NetworkService {
  
  private let config: NetworkConfigurable
  private let sessionManager: NetworkSessionManager
  private let logger: NetworkErrorLogger
  
  public init(
    config: NetworkConfigurable,
    sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
    logger: NetworkErrorLogger = DefaultNetworkErrorLogger()
  ) {
    self.config = config
    self.sessionManager = sessionManager
    self.logger = logger
  }
  
  public func request(endpoint: Requestable) -> AnyPublisher<Data, NetworkError> {
    do {
      let urlRequest = try endpoint.urlRequest(with: config)
      return request(request: urlRequest)
    } catch {
      return Fail(error: NetworkError.urlGeneration)
        .eraseToAnyPublisher()
    }
  }
  
  private func resolve(error: Error) -> NetworkError {
    if let networkError = error as? NetworkError {
      return networkError
    } else {
      let code = URLError.Code(rawValue: (error as NSError).code)
      switch code {
      case .notConnectedToInternet: return .notConnected
      case .cancelled: return .cancelled
      default: return .generic(error)
      }
    }
  }
  
  private func handleResponse(data: Data, response: URLResponse) throws -> Data {
    if let response = response as? HTTPURLResponse {
      if (200..<300).contains(response.statusCode) {
        return data
      } else {
        let error = NetworkError.error(statusCode: response.statusCode, data: data)
        logger.log(error: error)
        throw error
      }
    } else {
      logger.log(responseData: data, response: response)
      return data
    }
  }
  
  private func request(request: URLRequest) -> AnyPublisher<Data, NetworkError> {
    let session = sessionManager.request(request)
      .tryMap { (data, response) in
        try self.handleResponse(data: data, response: response)
      }
      .mapError { error -> NetworkError in
        let networkError = self.resolve(error: error)
        self.logger.log(error: networkError)
        return networkError
      }
      .eraseToAnyPublisher()
    
    logger.log(request: request)
    
    return session
  }
}
