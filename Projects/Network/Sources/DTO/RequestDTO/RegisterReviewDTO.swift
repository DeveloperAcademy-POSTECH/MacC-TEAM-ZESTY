//
//  RegisterReviewDTO.swift
//  Network
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct RegisterReviewDTO: Encodable {
    public let placeId: Int
    public let menuName: String?
    public let image: String?
    public let grade: Int
    public let reviewer: Int
    
    public init(placeId: Int, menuName: String? = nil, image: String? = nil, grade: Int, reviewer: Int) {
        self.placeId = placeId
        self.menuName = menuName
        self.image = image
        self.grade = grade
        self.reviewer = reviewer
    }
}

extension RegisterReviewDTO {
    public static let mock = RegisterReviewDTO(placeId: 0, menuName: "", image: "", grade: 0, reviewer: 0)
}
