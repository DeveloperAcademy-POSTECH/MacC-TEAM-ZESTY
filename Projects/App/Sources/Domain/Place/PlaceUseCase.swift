//
//  PlaceUseCase.swift
//  App
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class PlaceListUseCase {
    
    func fetchPlaceList(with page: Int, type: PlaceType) -> AnyPublisher<[Place], NetworkError> {
        let api: AnyPublisher<PlaceListDTO, NetworkError>
        
        guard let authorization = KeyChainManager.read(key: .authToken) else { return Fail(error: NetworkError.unauthorized("권한이 없습니다")).eraseToAnyPublisher() }
        print("auth: ", authorization)
        
        switch type {
        case .whole:
            api = PlaceAPI.fetchPlaceList(with: page, authorization: authorization)
        case .hot:
            api = PlaceAPI.fetchHotPlaceList(with: page,  authorization: authorization)
        }
        
        return api
            .map { placeList in
                placeList.map { Place(dto: $0) }
            }
            .eraseToAnyPublisher()
    }
    
}

enum PlaceType {
    case whole
    case hot
}
