//
//  PlaceSearchResultDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/11/03.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

struct PlaceSearchResultDTO: Codable {
    let id: Int
    let address, name, latitude, longitude: String
    let category, organization, creator: Int
    let images: [String]
    let kakaoPlaceID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, address, name, latitude, longitude, category, organization, creator, images
        case kakaoPlaceID = "kakaoPlaceId"
        case createdAt, updatedAt
    }
}

typealias PlaceSearchResultListDTO = [PlaceSearchResultDTO]
