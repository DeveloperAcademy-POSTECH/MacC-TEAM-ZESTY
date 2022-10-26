//
//  PlaceDetailUseCase.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/23.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

protocol PlaceDetailUseCaseType {
    func fetchPlaceDetail(with placeId: Int) -> AnyPublisher<Place, Error>
}

final class PlaceDetailUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<Place, Error> = .init()

    func fetchPlaceDetail(with placeId: Int) -> AnyPublisher<Place, Error> {
        PlaceAPI.fetchPlaceDetail(placeId: placeId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] placeDetailDTO in
                let place = Place(detailDTO: placeDetailDTO[0])
                self?.output.send(place)
            }
            .store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
}
