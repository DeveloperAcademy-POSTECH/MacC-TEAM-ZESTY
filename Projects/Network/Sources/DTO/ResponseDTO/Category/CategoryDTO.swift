//
//  CategoryDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct CategoryDTO: Decodable {
    public let id: Int
    public let name: String
    public let img: String
    public let createdAt, updatedAt: String
}

public typealias CategoryListDTO = [CategoryDTO]
