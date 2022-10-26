//
//  PlaceDetailDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/23.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public typealias PlaceDetailDTOResult = [PlaceDetailDTO] // 서버에서 데이터 잘못내려줘서 임시로

public struct PlaceDetailDTO: Decodable {
    public let placeID: Int
    public let placeName, address, lat, long: String
    public let category: Category
    public let evaluationSummary: EvaluationSummary
 
    public enum CodingKeys: String, CodingKey {
        case placeID = "placeId"
        case placeName, address, lat, long, category, evaluationSummary
    }
}

public struct Category: Decodable {
    public let id: Int
    public let name, createdAt, updatedAt: String
}

public struct EvaluationSummary: Decodable {
    public let goodCount, sosoCount, badCount: Int
}
