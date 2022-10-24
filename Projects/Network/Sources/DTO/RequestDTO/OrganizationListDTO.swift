//
//  OrganizationListDTO.swift
//  Network
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public typealias OrganizationListDTO = [OrganizationDTO]

public struct OrganizationDTO: Decodable {
    public let id: Int
    public let name: String
    public let domain: String
}
