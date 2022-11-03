//
//  KakaoPlace.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Network

struct KakaoPlace {
    let kakaoPlaceId: Int
    let placeName: String
    let lat: String
    let lon: String
    let address: String
}

extension KakaoPlace {
    
    init(dto: KakaoPlaceDTO) {
        kakaoPlaceId = dto.id
        placeName = dto.placeName
        lat = dto.latitude
        lon = dto.longitude
        address = dto.roadAddress
    }
    
}
