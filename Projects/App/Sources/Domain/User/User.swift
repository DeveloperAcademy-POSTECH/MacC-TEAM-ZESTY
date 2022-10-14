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
    let email: String
    let social: SocialProvider
    let nickname: String
    let authToken: String
    let organization: Int // [Int]
}

enum SocialProvider: String {
    case apple = "APPLE"
    case kakao = "KAKAO"
}
