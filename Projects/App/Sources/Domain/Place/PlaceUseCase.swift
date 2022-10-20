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
    
    func fetchPlaceList() {
        print("ing...")
        API.fetchPlaceList()
            .sink { error in
                print(error)
            } receiveValue: { placeListDTOs in
                let placeList = placeListDTOs.map { Place(dto: $0) }
            }
            .store(in: &cancelBag)
    }
    
}
