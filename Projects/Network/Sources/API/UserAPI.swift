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
    
    public static func postAccessToken(accessToken: String) -> AnyPublisher<UserOauthDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/login/oauth2/code/kakao", method: .get, queryParams: ["authToken": accessToken], headers: header)
        
        return networkService.request(with: endpoint, responseType: UserOauthDTO.self)
    }
    
    public static func getNicknameValidation(nickname: String) -> AnyPublisher<UserOauthDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/users/validate/nickname", method: .get, queryParams: ["nickname": nickname], headers: header)
        return networkService.request(with: endpoint, responseType: UserOauthDTO.self)
    }
    
    public static func putNickname(authorization: String) -> AnyPublisher<UserOauthDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/users/nickname", method: .put, queryParams: ["authorization": authorization], headers: header)
        return networkService.request(with: endpoint, responseType: UserOauthDTO.self)
    }

}
