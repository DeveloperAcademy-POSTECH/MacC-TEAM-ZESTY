//
//  OrgDetailDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/11/07.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

public struct OrgDetailDTO: Codable {
    public let countOfWithFriends, countOfRegisteredPlaceByOrg, countOfUploadedReviewPhoto: Int
}
