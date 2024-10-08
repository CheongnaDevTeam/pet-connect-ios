//
//  Endpoint.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import NetworkingInterface

public class Endpoint<R>: ResponseRequestable {
  
  public typealias Response = R
  
  public var path: String
  public var isFullPath: Bool
  public var method: HTTPMethodType
  public var headerParameters: [String : String]
  public var queryParametersEncodable: Encodable?
  public var queryParameters: [String : Any]
  public var bodyParametersEncodable: Encodable?
  public var bodyParameters: [String : Any]
  public var bodyEncoding: BodyEncoding
  public var responseDecoder: ResponseDecoder
  
  public init(
    path: String,
    isFullPath: Bool = false,
    method: HTTPMethodType,
    headerParameters: [String : String] = [:],
    queryParametersEncodable: Encodable? = nil,
    queryParameters: [String : Any] = [:],
    bodyParametersEncodable: Encodable? = nil,
    bodyParameters: [String : Any] = [:],
    bodyEncoding: BodyEncoding = .jsonSerializationData,
    responseDecoder: ResponseDecoder = JSONResponseDecoder()
  ) {
    self.path = path
    self.isFullPath = isFullPath
    self.method = method
    self.headerParameters = headerParameters
    self.queryParametersEncodable = queryParametersEncodable
    self.queryParameters = queryParameters
    self.bodyParametersEncodable = bodyParametersEncodable
    self.bodyParameters = bodyParameters
    self.bodyEncoding = bodyEncoding
    self.responseDecoder = responseDecoder
  }
}

extension Requestable {
  
  public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
    let url = try self.url(with: config)
    var urlRequest = URLRequest(url: url)
    var allHeaders: [String: String] = config.headers
    headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
    
    let bodyParameters = try bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
    if !bodyParameters.isEmpty {
      urlRequest.httpBody = encodeBody(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding)
    }
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = allHeaders
    return urlRequest
  }
  
  private func url(with config: NetworkConfigurable) throws -> URL {
    let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
    let endpoint = isFullPath ? path : baseURL.appending(path)
    
    guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
    var urlQueryItems = [URLQueryItem]()
    
    let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
    queryParameters.forEach {
      urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
    }
    config.queryParameters.forEach { /// query 기본 구성값?
      urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
    }
    urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
    guard let url = urlComponents.url else { throw RequestGenerationError.components }
    return url
  }
  
  private func encodeBody(bodyParameters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
    switch bodyEncoding {
    case .jsonSerializationData:
      return try? JSONSerialization.data(withJSONObject: bodyParameters)
    case .stringEncodingAscii:
      return bodyParameters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
    }
  }
}

private extension Dictionary {
  var queryString: String {
    return self.map { "\($0.key)=\($0.value)" }
      .joined(separator: "&")
      .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
  }
}

private extension Encodable {
  func toDictionary() throws -> [String: Any]? {
    let data = try JSONEncoder().encode(self)
    let jsonData = try JSONSerialization.jsonObject(with: data)
    return jsonData as? [String: Any]
  }
}
