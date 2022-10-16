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
    var multipart: [Multipart]? { get }
    var boundary: String? { get }
    var headers: [String: String]? { get }
}

extension Requestable {

    func urlRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)

        headers?.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = try dataBody()

        return urlRequest
    }

    private func url() throws -> URL {
        var components = URLComponents()

        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = try queryItems()

        guard let url = components.url else { throw NetworkError.urlComponent }
        return url
    }

    private func queryItems() throws -> [URLQueryItem]? {
        if let queryParams = try queryParams?.toDictionary() {
            if !queryParams.isEmpty {
                return queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        }
        return nil
    }
    
    private func dataBody() throws -> Data? {
        var dataBody = Data()
        
        guard let bodyParams = try bodyParams?.toDictionary() else { return nil }
        
        // multipart가 있을 경우
        if let multipart = multipart, let boundary = boundary {
            let bound = BoundaryType(boundary: boundary)
            
            // multipart 외 함께 전달하는 정보들
            for (key, value) in bodyParams {
                dataBody.append(bound.initial)
                dataBody.append("Content-Disposition: form-data; ")
                dataBody.append("name=\"\(key)\"\(bound.crlf)\(bound.crlf)\(value)\(bound.crlf)")
            }
            // multipart 정보
            for data in multipart {
                dataBody.append(bound.initial)
                dataBody.append("Content-Disposition: form-data; ")
                dataBody.append("name=\"\(data.mediaType)\"; filename=\"\(UUID()).\(data.extension)\"\(bound.crlf)")
                dataBody.append("Content-Type: \(data.mediaType)/\(data.extension)\(bound.crlf)\(bound.crlf)")
                dataBody.append(data.data)
                dataBody.append(bound.encapsulated)
            }
            dataBody.append(bound.final)
        }
        
        // multipart가 없는 경우
        else if !bodyParams.isEmpty {
            return try? JSONSerialization.data(withJSONObject: bodyParams)
        }
        
        return dataBody
    }

}

// MARK: - Utility

fileprivate extension Encodable {

    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }

}

fileprivate extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
}

fileprivate struct BoundaryType {
    let boundary: String
    let crlf = "\r\n"
    
    var initial: String { "--\(boundary)\(crlf)" }
    var encapsulated: String { "\(crlf)--\(boundary)\(crlf)" }
    var final: String { "\(crlf)--\(boundary)--\(crlf)" }
}
