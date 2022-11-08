//
//  UserProfileDTO.swift
//  Network
//
//  Created by Lee Myeonghwan on 2022/11/02.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

public struct UserProfileDTO: Decodable {
    public let id: Int
    public let nickname: String?
    public let email: String?
    public let authToken: String?
    public let social: String?
    public let organization: Int?
    public let authIdentifier: String
    public let deletedAt: String?
    public let createdAt: String
    public let updatedAt: String
    public let isVerified: Bool
}
