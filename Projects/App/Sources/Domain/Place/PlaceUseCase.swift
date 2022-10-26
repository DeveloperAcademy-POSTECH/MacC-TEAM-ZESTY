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
    
    private var cancelBag = Set<AnyCancellable>()
    
    func fetchPlaceList(with page: Int) -> AnyPublisher<[Place], NetworkError> {
        return PlaceAPI.fetchPlaceList(with: page)
            .map { placeList in
                placeList.map { Place(dto: $0) }
            }
            .eraseToAnyPublisher()
    }
    
}
