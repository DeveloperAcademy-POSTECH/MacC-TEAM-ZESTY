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

    public static func postSignUp(authorization: String, userDTO: SignUpUserDTO) -> AnyPublisher<Bool, NetworkError> {
        let header = ["Content-Type": "application/json", "Authorization": "\(authorization)"]
        let user = ["email": userDTO.email, "organizationName": userDTO.organizationName]
        let endpoint = Endpoint(path: "/api/users", method: .post, bodyParams: user, headers: header)
        
        return networkService.request(with: endpoint)
    }
    
    public static func postAccessToken(accessToken: String) -> AnyPublisher<UserOauthDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/login/oauth2/code/kakao", method: .get, queryParams: ["authToken": accessToken], headers: header)
        
        return networkService.request(with: endpoint, responseType: UserOauthDTO.self)
    }
    
    public static func getNicknameValidation(nickname: String) -> AnyPublisher<Bool, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/users/validate/nickname", method: .get, queryParams: ["nickname": nickname], headers: header)
        return networkService.request(with: endpoint)
    }
    
    public static func putNickname(authorization: String, nickname: String) -> AnyPublisher<Bool, NetworkError> {
        let header = ["Content-Type": "application/json", "Authorization": "\(authorization)"]
        let endpoint = Endpoint(path: "/api/users/nickname", method: .put, bodyParams: ["nickname": nickname], headers: header)
        return networkService.request(with: endpoint)
    }
    
    public static func postVerifyCode(codeDTO: VerifyCodeDTO) -> AnyPublisher<Bool, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let code = ["email": codeDTO.email, "code": codeDTO.code]
        let endpoint = Endpoint(path: "/api/users/verify", method: .post, bodyParams: code, headers: header)
        
        return networkService.request(with: endpoint)
    }

}
