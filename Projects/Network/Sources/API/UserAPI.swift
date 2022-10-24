//
//  UserAPI.swift
//  Network
//
//  Created by 리아 on 2022/10/21.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

public struct UserAPI {
    
    static let networkService = NetworkService()

    public static func postSignUp(userDTO: SignUpUserDTO) -> AnyPublisher<String, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let user = userDTO
        let endpoint = Endpoint(path: "/api/users", method: .post, bodyParams: user, headers: header)
        
        return networkService.request(with: endpoint, responseType: String.self)
    }

}
