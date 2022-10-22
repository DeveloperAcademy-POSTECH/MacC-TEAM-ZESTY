//
//  Organization.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct Organization {
    let id: Int
    let name: String
    let domain: String
    let memberCount: Int
    let imageCount: Int
    let placeCount: Int
//    let address: String
}

extension Organization {
    
    init(dto: OrganizationDTO) {
        id = dto.id
        name = dto.name
        domain = dto.domain
        memberCount = 1
        imageCount = 1
        placeCount = 1
    }

}
