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
    case redirection(String)
    case badRequest(String)
    case unauthorized(String)
    case forbidden(String)
    case notFound(String)
    case serverError(String)
    case unknown(String)
    
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
        case .redirection(let responseBody):
            return "🚨status code: 3XX🚨: 요청 완료를 위해 추가 작업 조치가 필요합니다. \n\(responseBody)"
        case .badRequest(let responseBody):
            return "🚨status code: 400🚨: 잘못된 문법입니다. \n\(responseBody)"
        case .unauthorized(let responseBody):
            return "🚨status code: 401🚨: 인증이 필요합니다. \n\(responseBody)"
        case .forbidden(let responseBody):
            return "🚨status code: 403🚨: 컨텐츠 접근 권한이 없습니다. \n\(responseBody)"
        case .notFound(let responseBody):
            return "🚨status code: 404🚨: 요청받은 리소스를 찾을 수 없습니다. \n\(responseBody)"
        case .serverError(let responseBody):
            return "🚨status code: 5XX🚨: 서버가 명백히 유효한 요청에 대한 충족을 실패했습니다. \n\(responseBody)"
        case .unknown(let responseBody):
            return "🚨unknown🚨: 알 수 없는 에러, \(responseBody)"
        }
    }
}
