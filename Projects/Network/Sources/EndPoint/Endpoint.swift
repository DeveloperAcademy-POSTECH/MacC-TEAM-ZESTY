//
//  Endpoint.swift
//  Network
//
//  Created by 리아 on 2022/10/10.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

final class Endpoint: Requestable {

    var scheme: String
    var host: String
    var path: String
    var method: HttpMethod
    var queryParams: Encodable?
    var bodyParams: Encodable?
    var headers: [String: String]?

    init(scheme: String = "https",
         host: String = "",
         path: String = "",
         method: HttpMethod = .get,
         queryParams: Encodable? = nil,
         bodyParams: Encodable? = nil,
         headers: [String: String]?) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.method = method
        self.queryParams = queryParams
        self.bodyParams = bodyParams
        self.headers = headers
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}