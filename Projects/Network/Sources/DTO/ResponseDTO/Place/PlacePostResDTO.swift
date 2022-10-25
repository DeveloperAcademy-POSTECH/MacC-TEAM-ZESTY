//
//  PlacePostResDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct PlacePostResDTO: Decodable {
    public let id: Int
    public let address, name, latitude, longitude: String
    public let category, organization, creator: Int
    public let images: [String]
    public let kakaoPlaceID: Int
    public let createdAt, updatedAt: String

    public enum CodingKeys: String, CodingKey {
        case id, address, name, latitude, longitude, category, organization, creator, images
        case kakaoPlaceID = "kakaoPlaceId"
        case createdAt, updatedAt
    }
}
