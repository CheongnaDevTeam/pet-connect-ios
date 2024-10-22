//
//  NetworkService.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import RxSwift

public protocol NetworkService {
  func request(endpoint: Requestable) -> Observable<Data>
//  func request(endpoint: Requestable) -> AnyPublisher<Data, NetworkError>
}

public protocol NetworkSessionManager {
  typealias NetworkingOutput = (data: Data, response: URLResponse)
  func request(_ request: URLRequest) -> Observable<NetworkingOutput>
//  func request(_ request: URLRequest) -> AnyPublisher<NetworkingOutput, URLError>
}

public protocol NetworkErrorLogger {
  func log(request: URLRequest)
  func log(responseData data: Data?, response: URLResponse?)
  func log(error: Error)
  func log(responseData data: Data, response: URLResponse)
}
