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
    public let id: Int
    public let address: String
    public let latitude: String
    public let longitude: String
    public let organizations: [Int]
    public let creator: Int
    public let createdAt: String
    public let updatedAt: String
}
