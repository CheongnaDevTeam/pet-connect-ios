//
//  Publisher+.swift
//  PetConnect
//
//  Created by 이원빈 on 9/2/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import Combine

extension Publisher {
  func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
    return sink(receiveCompletion: { completion in
      switch completion {
      case let .failure(error):
        result(.failure(error))
      default: break
      }
    }, receiveValue: { value in
      result(.success(value))
    })
  }
}
