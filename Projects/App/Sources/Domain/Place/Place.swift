//
//  Place.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

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
