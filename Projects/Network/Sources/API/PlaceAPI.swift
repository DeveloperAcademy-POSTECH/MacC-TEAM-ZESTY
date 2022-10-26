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

    public static func fetchPlaceList(with page: Int) -> AnyPublisher<PlaceListDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let query = ["cursor": "\(page)"]
        let endpoint = Endpoint(path: "/api/places", queryParams: query, headers: header)
        
        return networkService.request(with: endpoint, responseType: PlaceListDTO.self)
    }
    
    public static func fetchHotPlaceList(with page: Int) -> AnyPublisher<PlaceListDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let query = ["cursor": "\(page)"]
        let endpoint = Endpoint(path: "/api/places/goods", queryParams: query, headers: header)
        
        return networkService.request(with: endpoint, responseType: PlaceListDTO.self)
    }

    public static func fetchPlaceDetail(placeId: Int) ->
        AnyPublisher<PlaceDetailDTOResult, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/places/\(placeId)", headers: header)
        
        return networkService.request(with: endpoint, responseType: PlaceDetailDTOResult.self)
    }
    
    public static func fetchReviewList(placeId: Int) ->
        AnyPublisher<PlaceReviewListDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let query = ["placeId": "\(placeId)"]
        let endpoint = Endpoint(path: "/api/review", queryParams: query, headers: header)
            
            return networkService.request(with: endpoint, responseType: PlaceReviewListDTO.self)
    }

}
