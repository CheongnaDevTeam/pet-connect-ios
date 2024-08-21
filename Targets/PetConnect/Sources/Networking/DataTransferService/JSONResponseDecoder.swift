//
//  JSONResponseDecoder.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

public class JSONResponseDecoder: ResponseDecoder {
  private let jsonDecoder = JSONDecoder()
  
  public init() {}
  
  public func decode<T: Decodable>(_ data: Data) throws -> T {
    return try jsonDecoder.decode(T.self, from: data)
  }
}
