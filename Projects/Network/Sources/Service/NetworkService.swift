//
//  NetworkService.swift
//  Network
//
//  Created by 리아 on 2022/10/10.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

protocol NetworkServable {
    func request<E: Requestable, T: Decodable>(with endpoint: E, responseType: T.Type)
    -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServable {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

extension NetworkService {
    
    func request<E: Requestable>(with endpoint: E)
    -> AnyPublisher<Bool, NetworkError> {
        do {
            let request = try endpoint.urlRequest()
            
            return session.dataTaskPublisher(for: request)
                .tryMap({ (data, response) in
                    if let error = self.checkError(data: data, response: response) {
                        throw error
                    }
                    return true
                })
                .mapError({ error in
                    if let error = error as? NetworkError {
                        return error
                    }
                    return NetworkError.invalidUrl(error)
                })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.invalidUrlRequest(error)).eraseToAnyPublisher()
        }
    }
    
    func request<E: Requestable, T: Decodable>(with endpoint: E, responseType: T.Type)
    -> AnyPublisher<T, NetworkError> {
        do {
            let request = try endpoint.urlRequest()

            return session.dataTaskPublisher(for: request)
                .tryMap({ (data, response) in
                    if let error = self.checkError(data: data, response: response) {
                        throw error
                    }
                    let decodedData: T
                    do {
                        decodedData = try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        throw NetworkError.decodingError(error)
                    }
                    return decodedData
                })
                .mapError({ error in
                    if let error = error as? NetworkError {
                        return error
                    }
                    return NetworkError.invalidUrl(error)
                })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.invalidUrlRequest(error)).eraseToAnyPublisher()
        }
    }
    
    private func checkError(data: Data, response: URLResponse) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return NetworkError.badResponse
        }
        if let responseBody = String(data: data, encoding: String.Encoding.utf8) {
            switch httpResponse.statusCode {
            case 200..<300: return nil
            case 300..<400: return .redirection(responseBody)
            case 400: return .badRequest(responseBody)
            case 401: return .unauthorized(responseBody)
            case 403: return .forbidden(responseBody)
            case 404: return .notFound(responseBody)
            case 500...: return .serverError(responseBody)
            default: return .unknown("\(httpResponse.statusCode)")
            }
        }
        return .unknown("response body -> string 전환 실패")
    }
    
}
