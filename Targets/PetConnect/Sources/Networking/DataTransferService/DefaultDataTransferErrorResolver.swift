//
//  DefaultDataTransferErrorResolver.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

public class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
  public init() {}
  
  public func resolve(error: NetworkError) -> Error {
    return error
  }
}
