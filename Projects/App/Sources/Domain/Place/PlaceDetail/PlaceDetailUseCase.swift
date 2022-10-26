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
    func fetchReviewList(with placeId: Int) -> AnyPublisher<[Review], Error>
}

final class PlaceDetailUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    private let outputPlace: PassthroughSubject<Place, Error> = .init()
    private let outputReview: PassthroughSubject<[Review], Error> = .init()

    func fetchPlaceDetail(with placeId: Int) -> AnyPublisher<Place, Error> {
        PlaceAPI.fetchPlaceDetail(placeId: placeId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] placeDetailDTO in
                let place = Place(detailDTO: placeDetailDTO[0])
                self?.outputPlace.send(place)
            }
            .store(in: &cancelBag)
        
        return outputPlace.eraseToAnyPublisher()
        
    }
    
    func fetchReviewList(with placeId: Int) -> AnyPublisher<[Review], Error> {
        PlaceAPI.fetchReviewList(placeId: placeId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] placeReviewListDTO in
                let reviewList = placeReviewListDTO.map {
                    Review(placeReviewDto: $0) }
                self?.outputReview.send(reviewList)
            }
            .store(in: &cancelBag)
        
        return outputReview.eraseToAnyPublisher()
    }
    
}
