//
//  CategoryAPI.swift
//  Network
//
//  Created by 리아 on 2022/10/21.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

public struct CategoryAPI {
    
    static let networkService = NetworkService()

    public static func fetchCategoryList() -> AnyPublisher<CategoryListDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/categories", headers: header)
        
        return networkService.request(with: endpoint, responseType: CategoryListDTO.self)
    }
}
