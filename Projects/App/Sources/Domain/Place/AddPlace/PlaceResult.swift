//
//  PlaceResult.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct PlaceResult {
    let id: Int
    let kakaoPlaceId: Int
    let creator: String
    let organizationId: String
    let name: String
    let address: String
    let category: Category
    let createdAt: Date
}

extension PlaceResult {
    
    init(dto: PlacePostResDTO) {
        id = dto.id
        kakaoPlaceId = dto.kakaoPlaceID
        creator = dto.creator.nickname
        organizationId = dto.organization.name
        name = dto.name
        address = dto.address
        category = Category(id: dto.category.id,
                            name: dto.category.name,
                            imageURL: dto.category.img)
        createdAt = {
            let string = dto.createdAt
            let array = string.split(separator: ".")
            let dateStr = "" + array[0]
            return dateStr.toDate() ?? Date()
        }()
    }

}
