//
//  PlacePostResDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct PlacePostResDTO: Codable {
    public let id: Int
    public let address, name, latitude, longitude: String
    public let category: Category
    public let organization: Organization
    public let creator: Creator
    public let kakaoPlaceID: Int
    public let createdAt, updatedAt: String

    public enum CodingKeys: String, CodingKey {
        case id, address, name, latitude, longitude, category, organization, creator
        case kakaoPlaceID = "kakaoPlaceId"
        case createdAt, updatedAt
    }
}

// MARK: - Category
public struct Category: Codable {
    public let id: Int
    public let name: String
    public let img: String
    public let createdAt, updatedAt: String
}

// MARK: - Creator
public struct Creator: Codable {
    public let nickname: String
}

// MARK: - Organization
public struct Organization: Codable {
    public let id: Int
    public let name, domain: String
}
