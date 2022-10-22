//
//  User.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let email: String?
    let social: SocialProvider
    let nickname: String?
    let authToken: String
    let organizationId: Int? // [Int]
    
    init(id: Int, email: String? = nil, social: SocialProvider, nickname: String? = nil, authToken: String, organizationId: Int? = nil) {
        self.id = id
        self.email = email
        self.social = social
        self.nickname = nickname
        self.authToken = authToken
        self.organizationId = organizationId
    }
}

enum SocialProvider: String {
    case apple = "APPLE"
    case kakao = "KAKAO"
}
