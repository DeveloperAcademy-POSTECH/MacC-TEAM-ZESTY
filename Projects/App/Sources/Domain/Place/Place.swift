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
    let creator: User
    let organizationId: Int
    let name: String
    let address: String
    let lat: String
    let lan: String
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
        creator = User.mockData[0]
        organizationId = 0
        name = dto.shopName
        address = ""
        lat = ""
        lan = ""
        category = Category.mockData
        evaluationSum = EvaluationSum(dto: dto.evaluations)
        reviews = dto.reviewContent.map { Review($0) }
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
