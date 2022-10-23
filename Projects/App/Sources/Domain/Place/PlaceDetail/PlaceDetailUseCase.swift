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
    func fetchPlaceDetail(with placeId: Int) -> AnyPublisher<Place, Never>
    func fetchPlaceDetail2(with placeId: Int) -> AnyPublisher<Result<Place, Error>, Never>
}

final class PlaceDetailUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<Place, Never> = .init()

    func fetchPlaceDetail(with placeId: Int) -> AnyPublisher<Place, Never> {
        PlaceAPI.fetchPlaceDetail(placeId: placeId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] placeDetailDTO in
                let place = Place(detailDTO: placeDetailDTO)
                print("🔥🔥\(place)🔥🔥")
                self?.output.send(place)
                print("🔥🔥성공적으로 보냈어요🔥🔥")
            }
            .store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    private let output2: PassthroughSubject<Result<Place, Error>, Never> = .init()
    
    func fetchPlaceDetail2(with placeId: Int) -> AnyPublisher<Result<Place, Error>, Never> {
        PlaceAPI.fetchPlaceDetail(placeId: placeId)
            .sink { error in
                switch error {
                case .failure(let error):
                    print("🔥🔥", error.localizedString)
                    self.output2.send(.failure(error))
                    print("🔥🔥에러를 보냈어요🔥🔥")
                case .finished: break
                }
            } receiveValue: { [weak self] placeDetailDTO in
                let place = Place(detailDTO: placeDetailDTO)
                print("🔥🔥\(place)🔥🔥")
                self?.output2.send(.success(place))
                print("🔥🔥성공적으로 보냈어요🔥🔥")
            }
            .store(in: &cancelBag)
        
        return output2.eraseToAnyPublisher()
    }
    
//    func fetchPlaceDetail(placeId: Int) -> AnyPublisher<Place, Never> {
//        PlaceAPI.fetchPlaceDetail(placeId: placeId)
//            .sink { error in
//                switch error {
//                case .failure(let error): print(error.localizedString)
//                case .finished: break
//                }
//            } receiveValue: { placeDetailDTO in
//                let place = Place(detailDTO: placeDetailDTO)
//                print("🔥🔥\(place)🔥🔥")
//
//            }
//            .store(in: &cancelBag)
//    }
    
}
