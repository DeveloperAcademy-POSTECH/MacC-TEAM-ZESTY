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
    
    init(dto: PlaceListDTO) {
        id = dto.id
        creator = User.mockData[0]
        organizationId = dto.organizations[0]
        name = "name"
        address = dto.address
        lat = dto.latitude
        lan = dto.longitude
        category = Category.mockData
        evaluationSum = EvaluationSum.mockData[0]
        reviews = Review.mockData
    }

}


