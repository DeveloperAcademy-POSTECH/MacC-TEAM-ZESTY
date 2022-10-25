//
//  PlacePostDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct PlacePostDTO: Encodable {
    public let address, name, latitude, longitude: String
    public let category, organizations, creator: Int
    public let placeImage: String
    public let kakaoPlaceID: Int

    public enum CodingKeys: String, CodingKey {
        case address, name, latitude, longitude, category, organizations, creator, placeImage
        case kakaoPlaceID = "kakaoPlaceId"
    }
}
