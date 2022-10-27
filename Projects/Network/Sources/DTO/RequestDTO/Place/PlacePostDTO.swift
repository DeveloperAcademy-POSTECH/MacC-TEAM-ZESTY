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
    public let placeImage: String // 서버 임시용
    public let kakaoPlaceID: Int

    public enum CodingKeys: String, CodingKey {
        case address, name, latitude, longitude, category, organizations, creator, placeImage
        case kakaoPlaceID = "kakaoPlaceId"
    }
    
    public init(address: String, name: String, latitude: String, longitude: String, category: Int, organizations: Int, creator: Int, placeImage: String, kakaoPlaceID: Int) {
        self.address = address
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.organizations = organizations
        self.creator = creator
        self.placeImage = placeImage
        self.kakaoPlaceID = kakaoPlaceID
    }
    
}
