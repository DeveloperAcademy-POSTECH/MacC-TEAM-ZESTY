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
    
    func fetchPlaceList(with page: Int) {
        PlaceAPI.fetchPlaceList(with: page)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { placeListDTO in
                let placeList = placeListDTO.map { Place(dto: $0) }
            }
            .store(in: &cancelBag)
    }
    
}
