//
//  ResponseRequestable.swift
//  Network
//
//  Created by 리아 on 2022/10/10.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

protocol Requestable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryParams: Encodable? { get }
    var bodyParams: Encodable? { get }
    var headers: [String: String]? { get }
}

extension Requestable {

    func getUrlRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)

        // httpBody
        if let bodyParams = try bodyParams?.toDictionary() {
            if !bodyParams.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams)
            }
        }
        // httpMethod
        urlRequest.httpMethod = method.rawValue
        // header
        headers?.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }

    private func url() throws -> URL {
        var components = URLComponents()

        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = try getQueryItems()

        guard let url = components.url else { throw NetworkError.urlComponent }
        return url
    }

    private func getQueryItems() throws -> [URLQueryItem]? {
        if let queryParams = try queryParams?.toDictionary() {
            if !queryParams.isEmpty {
                return queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        }
        return nil
    }

}

extension Encodable {

    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }

}
