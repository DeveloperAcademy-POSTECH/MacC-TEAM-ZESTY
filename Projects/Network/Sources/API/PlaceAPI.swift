//
//  PlaceAPI.swift
//  Network
//
//  Created by 리아 on 2022/10/21.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

public struct PlaceAPI {
    
    static let networkService = NetworkService()

    public static func fetchPlaceList() -> AnyPublisher<[PlaceListDTO], NetworkError> {
        let header = ["Content-Type": "application/json"]
        let query = ["cursor": "0"]
        let endpoint = Endpoint(path: "/api/places", queryParams: query, headers: header)
        
        return networkService.request(with: endpoint, responseType: [PlaceListDTO].self)
    }

}
