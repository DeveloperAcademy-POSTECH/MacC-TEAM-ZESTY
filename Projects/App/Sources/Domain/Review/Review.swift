//
//  Review.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct Review {
    let id: Int
    let placeId: Int
    let reviewer: User?
    let evaluation: Evaluation
    let menuName: String?
    let imageURL: String?
    let createdAt: Date
//    let updatedAt: Date
}

enum Evaluation {
    case good
    case soso
    case bad
}

extension Review {
    
    init(_ dto: ReviewDTO) {
        id = 0
        placeId = 0
        reviewer = User.mockData[0]
        evaluation = .good
        menuName = dto.menuname
        imageURL = dto.image
        createdAt = Date()
    }
    
    init(placeReviewDto dto: PlaceReviewDTO) {
        id = 0
        placeId = 0
        reviewer = nil
        evaluation = {
            if dto.evaluationSummary.goodCount == 1 {
                return .good
            } else if dto.evaluationSummary.sosoCount == 1 {
                return .soso
            } else {
                return .bad
            }
        }()
        menuName = dto.menuName
        imageURL = dto.image
        createdAt = dto.createdAt.toDate()!
    }
    
}
