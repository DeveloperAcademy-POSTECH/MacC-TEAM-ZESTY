//
//  Place.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct Place {
    let id: Int
    let kakaoPlaceId: Int
    let creator: User?
    let organizationId: Int
    let name: String
    let address: String
    let lat: String
    let lon: String
    let category: [Category]
    let evaluationSum: EvaluationSum
    let reviews: [Review] // Preview Image
}

struct EvaluationSum {
    let good: Int
    let soso: Int
    let bad: Int
}

extension Place {
    
    init(dto: PlaceDTO) {
        id = 1
        kakaoPlaceId = 0
        creator = User.mockData[0]
        organizationId = 0
        name = dto.shopName
        address = ""
        lat = ""
        lon = ""
        category = Category.mockData
        evaluationSum = EvaluationSum(dto: dto.evaluations)
        reviews = dto.reviewContent.map { Review($0) }
    }
    
    init(detailDTO dto: PlaceDetailDTO) {
        id = dto.placeID
        kakaoPlaceId = dto.placeID
        creator = User.mockData[0]
        organizationId = -1
        name = dto.placeName
        address = dto.address
        lat = dto.lat
        lon = dto.long
        category = [Category(id: dto.category.id, name: dto.category.name, imageURL: nil)]
        evaluationSum = EvaluationSum(good: dto.evaluationSummary.goodCount,
                                      soso: dto.evaluationSummary.sosoCount,
                                      bad: dto.evaluationSummary.badCount)
        reviews = []
    }
    
}

extension EvaluationSum {
    
    init(dto: EvaluationDTO?) {
        if let dto = dto {
            good = dto.one
            soso = dto.two
            bad = dto.three
        } else {
            good = 0
            soso = 0
            bad = 0
        }
    }
    
}
