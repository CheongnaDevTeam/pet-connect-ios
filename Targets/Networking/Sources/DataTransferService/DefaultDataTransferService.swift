//
//  DefaultDataTransferService.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import Combine
import NetworkingInterface

public final class DefaultDataTransferService {
  
  private let networkService: NetworkService
  private let errorResolver: DataTransferErrorResolver
  private let errorLogger: DataTransferErrorLogger
  
  public init(
    networkService: NetworkService,
    errorResolver: DataTransferErrorResolver,
    errorLogger: DataTransferErrorLogger
  ) {
    self.networkService = networkService
    self.errorResolver = errorResolver
    self.errorLogger = errorLogger
  }
}

extension DefaultDataTransferService: DataTransferService {
  
  public func request<T, E>(
    with endpoint: E
  ) -> AnyPublisher<T, DataTransferError> where T : Decodable, T == E.Response, E : ResponseRequestable {
    
    return networkService.request(endpoint: endpoint)
      .tryMap { data -> T in
        let result: T = try self.decode(data: data, decoder: endpoint.responseDecoder)
        return result
      }
      .mapError { error -> DataTransferError in
        self.errorLogger.log(error: error)
        
        if let networkError = error as? NetworkError {
          let transferError = self.resolve(networkError: networkError)
          return transferError
        } else if let transferError = error as? DataTransferError {
          return transferError
        } else {
          return DataTransferError.resolvedNetworkFailure(error)
        }
      }
      .eraseToAnyPublisher()
  }
  
  public func request<E>(
    with endpoint: E
  ) -> AnyPublisher<Data, DataTransferError> where E: ResponseRequestable, E.Response == Data {
    
    return networkService.request(endpoint: endpoint)
      .mapError { networkError -> DataTransferError in
        self.errorLogger.log(error: networkError)
        let transferError = self.resolve(networkError: networkError)
        return transferError
      }
      .eraseToAnyPublisher()
  }
  
  private func decode<T: Decodable>(data: Data, decoder: ResponseDecoder) throws -> T {
    do {
      let result: T = try decoder.decode(data)
      return result
    } catch {
      self.errorLogger.log(error: error)
      throw DataTransferError.parsing(error)
    }
  }
  
  private func resolve(networkError error: NetworkError) -> DataTransferError {
    let resolvedError = self.errorResolver.resolve(error: error)
    return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
  }
}
