//
//  ReviewAPI.swift
//  Network
//
//  Created by 리아 on 2022/10/21.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

public struct ReviewAPI {
    
    static let networkService = NetworkService()

    public static func dispatchPlace(place: Any) -> Any {
        let boundary = UUID().uuidString
        let header = ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        let endpoint = Endpoint(path: "/place", method: .post, headers: header)
        
        return networkService.request(with: endpoint, responseType: String.self) // responsable type
    }
    
    public static func postReview(with DTO: RegisterReviewDTO) -> AnyPublisher<ReviewDetailDTO, NetworkError> {
        return Just(ReviewDetailDTO.mock)
            .mapError { _ in
                NetworkError.unknown("will never be executed")
            }
            .eraseToAnyPublisher()
    }

}
