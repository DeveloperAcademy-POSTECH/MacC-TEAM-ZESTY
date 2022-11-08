//
//  VerifyCodeDTO.swift
//  Network
//
//  Created by 김태호 on 2022/11/08.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

public struct VerifyCodeDTO: Encodable {
    public let id: Int
    public let email: String
    public let code: String
    
    public init(id: Int, email: String, code: String) {
        self.id = id
        self.email = email
        self.code = code
    }
    
}
