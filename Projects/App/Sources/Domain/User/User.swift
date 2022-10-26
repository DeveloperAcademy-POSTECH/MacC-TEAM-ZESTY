//
//  User.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct User {
    let id: Int
    let email: String
    let social: SocialProvider
    let nickname: String
    let authToken: String
    let organizationId: Int // [Int]
}

enum SocialProvider: String {
    case apple = "APPLE"
    case kakao = "KAKAO"
}

extension User {
    
    init(_ dto: ReviewUserDTO) {
        id = 0
        email = ""
        social = .apple
        nickname = dto.nickname
        authToken = ""
        organizationId = 0
    }
    
}
