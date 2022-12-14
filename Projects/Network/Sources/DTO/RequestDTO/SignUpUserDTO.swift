//
//  SignUpUserDTO.swift
//  Network
//
//  Created by 리아 on 2022/10/20.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct SignUpUserDTO: Encodable {
    public let email: String
    public let organizationName: String
    
    public init(email: String, organizationName: String) {
        self.email = email
        self.organizationName = organizationName
    }
    
}
