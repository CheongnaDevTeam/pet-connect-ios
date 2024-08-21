//
//  RawDataResponseDecoder.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

public class RawDataResponseDecoder: ResponseDecoder {
  
  public init() {}
  
  enum CodingKeys: String, CodingKey {
    case `default` = ""
  }
  
  public func decode<T>(_ data: Data) throws -> T where T : Decodable {
    if T.self is Data.Type, let data = data as? T {
      return data
    } else {
      let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
      throw Swift.DecodingError.typeMismatch(T.self, context)
    }
  }
}
