//
//  KakaoPlaceDTO.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
public struct KakaoPlaceDTO: Codable {
    public let id: Int
    public let address, phone, longitude, latitude: String
    public let url, roadAddress, placeName: String
}

public typealias KakaoPlaceListDTO = [KakaoPlaceDTO]
