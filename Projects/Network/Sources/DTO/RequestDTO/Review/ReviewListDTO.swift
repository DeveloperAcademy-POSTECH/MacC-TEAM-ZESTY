//
//  ReviewListDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public typealias PlaceReviewListDTO = [PlaceReviewDTO]

public struct PlaceReviewDTO: Decodable {
    public let evaluationSummary: EvaluationSummary
    public let createdAt, image, menuName: String
}
