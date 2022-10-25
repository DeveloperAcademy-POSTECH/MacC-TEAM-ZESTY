//
//  ReviewDetailDTO.swift
//  Network
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct ReviewDetailDTO: Decodable {
    public let id: Int
    public let evaluation: Int
    public let reviewer: ReviewUserDTO
    public let image: String
    public let place: ReviewPlaceDTO
    public let menuName: String
    public let createdAt: String
    public let updatedAt: String
 }

public extension ReviewDetailDTO {
    static let mock = ReviewDetailDTO(id: 0,
                                      evaluation: 0,
                                      reviewer: ReviewUserDTO(nickname: "아보카도"),
                                      image: "https://unsplash.com/photos/UC0HZdUitWY",
                                      place: ReviewPlaceDTO(id: 0,
                                                            name: "요기쿠시동",
                                                            address: "경북 포항시 남구 효자동길6번길 34-1 1층 요기쿠시동",
                                                            category: CategoryDTO(id: 2, name: "일식")),
                                      menuName: "암튼 꼬치",
                                      createdAt: "2022-10-24T16:47:55.257Z",
                                      updatedAt: "2022-10-24T16:47:55.257Z")
}

public struct ReviewUserDTO: Decodable {
    public let nickname: String
}

public struct ReviewPlaceDTO: Decodable {
    public let id: Int
    public let name: String
    public let address: String
    public let category: CategoryDTO
}
