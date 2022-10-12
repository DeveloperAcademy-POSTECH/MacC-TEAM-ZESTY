//
//  NetworkError.swift
//  Network
//
//  Created by 리아 on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case urlComponent
    case invalidUrl
    case invalidUrlRequest
    case decodingError
}
