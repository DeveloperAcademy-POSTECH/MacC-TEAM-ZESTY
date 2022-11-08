//
//  User.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct User: Hashable {
    let id: Int
    let nickname: String
}

extension User {
    
    init(_ dto: ReviewUserDTO) {
        id = 0
        nickname = dto.nickname
    }
    
}
