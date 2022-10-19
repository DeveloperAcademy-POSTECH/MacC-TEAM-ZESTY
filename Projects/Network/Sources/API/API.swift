//
//  API.swift
//  Network
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

public struct API {
    
    static let networkService = NetworkService()

    // get
    public static func fetchPlaceList() -> AnyPublisher<[PlaceListDTO], NetworkError> {
        let header = ["Content-Type": "application/json"]
        let query = ["cursor": "0"]
        let endpoint = Endpoint(path: "/api/places", queryParams: query, headers: header)
        
        return networkService.request(with: endpoint, responseType: [PlaceListDTO].self)
    }
    
    public static func fetchOrgList() -> AnyPublisher<[OrganizationListDTO], NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/organizations", headers: header)
        
        return networkService.request(with: endpoint, responseType: [OrganizationListDTO].self)
    }
    
    // upload image
    public static func dispatchPlace(place: Any) -> Any {
        let boundary = UUID().uuidString
        let header = ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        let endpoint = Endpoint(path: "/place", method: .post, headers: header)
        
        return networkService.request(with: endpoint, responseType: String.self) // responsable type
    }

}
