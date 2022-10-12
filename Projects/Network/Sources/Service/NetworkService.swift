//
//  NetworkService.swift
//  Network
//
//  Created by 리아 on 2022/10/10.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

protocol NetworkServiceable {
    func request<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, NetworkError>
    func request<E: ResponseRequestable, T: Decodable>(with endpoint: E, responseType: T.Type)
    -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServiceable {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

}

extension NetworkService {

    // get, delete
    func request<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        return session.dataTaskPublisher(for: url)
            .checkError()
            .decode()
    }

    // post, put
    func request<E: ResponseRequestable, T: Decodable>(with endpoint: E, responseType: T.Type)
    -> AnyPublisher<T, NetworkError> {
        do {
            let request = try endpoint.getUrlRequest()

            return session.dataTaskPublisher(for: request)
                .checkError()
                .decode()
        } catch {
            return Fail(error: NetworkError.invalidUrlRequest).eraseToAnyPublisher()
        }
    }

}

// MARK: - Error Handling

extension URLSession.DataTaskPublisher {

    // TODO: Error Handling
    func checkError() -> AnyPublisher<Data, NetworkError> {
        self.mapError { _ in
            NetworkError.invalidUrl
        }
        .map { (data, _) in
            return data
        }
        .eraseToAnyPublisher()
    }

}

extension AnyPublisher<Data, NetworkError> {

    func decode<T: Decodable>() -> AnyPublisher<T, NetworkError> {
        self.decode(type: T.self, decoder: JSONDecoder())
        .mapError { _ in
            NetworkError.decodingError
        }
        .eraseToAnyPublisher()
    }

}
