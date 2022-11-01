//
//  PlaceListDTO.swift
//  Network
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public typealias PlaceListDTO = [PlaceDTO]

public struct PlaceDTO: Decodable {
    public let shopName: String
    public let evaluations: EvaluationDTO?
    public let reviewContent: [ReviewDTO]
    public let placeId: Int
}

public struct EvaluationDTO: Decodable {
    public let one: Int
    public let two: Int
    public let three: Int
    public let byNumber: Int?
}

public struct ReviewDTO: Decodable {
    public let menuName: String?
    public let image: String?
    public let reviewer: Int
    public let registeredAt: String
}
