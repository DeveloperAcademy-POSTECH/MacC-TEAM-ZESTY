//
//  NetworkError.swift
//  Network
//
//  Created by 리아 on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case urlComponent
    case invalidUrl(Error)
    case invalidUrlRequest(Error)
    case badResponse
    case decodingError(Error)
    case status(Int)
    case unknown(Error)
    
    public var localizedString: String {
        switch self {
        case .urlComponent:
            return "🚨url component error🚨: url 생성 과정 문제"
        case .invalidUrl(let error):
            return "🚨invalid url🚨: \(error.localizedDescription)"
        case .invalidUrlRequest(let error):
            return "🚨invalid url request🚨: \(error.localizedDescription)"
        case .badResponse:
            return "🚨bad response🚨: response를 받지 못했습니다."
        case .decodingError(let error):
            return "🚨decoding error🚨: \(error.localizedDescription)"
        case .status(let code):
            return "🚨invalid status🚨 status code: \(code)"
        case .unknown(let error):
            return "🚨unknown🚨: 알 수 없는 에러, \(error.localizedDescription)"
        }
    }
}
