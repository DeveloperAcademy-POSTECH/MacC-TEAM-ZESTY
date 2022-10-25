//
//  AddPlaceUseCase.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

protocol AddPlaceUseCaseType {
    func searchKakaoPlaces(with name: String) -> AnyPublisher<[KakaoPlace], Error>
}

final class AddPlaceUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<[KakaoPlace], Error> = .init()

    func searchKakaoPlaces(with name: String) -> AnyPublisher<[KakaoPlace], Error> {
        PlaceAPI.getKakaoPlaceList(placeName: name)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] kakaoPlaceListDTO in
                let searchResults = kakaoPlaceListDTO.map {
                    KakaoPlace(dto: $0)
                }
                self?.output.send(searchResults)
            }
            .store(in: &cancelBag)

        return output.eraseToAnyPublisher()
    }
    
//
//        PlaceAPI.fetchReviewList(placeId: placeId)
//            .sink { error in
//                switch error {
//                case .failure(let error): print(error.localizedString)
//                case .finished: break
//                }
//            } receiveValue: { [weak self] placeReviewListDTO in
//                let reviewList = placeReviewListDTO.map {
//                    Review(placeReviewDto: $0) }
//                self?.outputReview.send(reviewList)
//            }
//            .store(in: &cancelBag)
//
//        return outputReview.eraseToAnyPublisher()
    
}
