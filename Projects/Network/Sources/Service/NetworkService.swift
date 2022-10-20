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

    func request<E: Requestable, T: Decodable>(with endpoint: E, responseType: T.Type)
    -> AnyPublisher<T, NetworkError> {
        do {
            let request = try endpoint.urlRequest()
            
            return session.dataTaskPublisher(for: request)
                .mapError { error in
                    NetworkError.invalidUrl(error)
                }
                .flatMap { (data, response) in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return Fail<T, NetworkError>(error: NetworkError.badResponse).eraseToAnyPublisher()
                    }
                    guard 200..<300 ~= httpResponse.statusCode else {
                        return Fail<T, NetworkError>(error: NetworkError.status(httpResponse.statusCode)).eraseToAnyPublisher()
                    }
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { error in
                            NetworkError.decodingError(error)
                        }
                        .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.invalidUrlRequest(error)).eraseToAnyPublisher()
        }
    }

}
