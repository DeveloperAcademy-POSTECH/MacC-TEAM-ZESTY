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
    func checkRegisterdPlace(with kakaoPlaceId: Int) -> AnyPublisher<Bool, Error>
}

final class AddPlaceUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<[KakaoPlace], Error> = .init()
    private let outputBool: PassthroughSubject<Bool, Error> = .init()

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
    
    func checkRegisterdPlace(with kakaoPlaceId: Int) -> AnyPublisher<Bool, Error> {
        PlaceAPI.checkRegisterdPlace(kakaoPlaceId: kakaoPlaceId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] isRegisterd in
                self?.outputBool.send(isRegisterd)
            }
            .store(in: &cancelBag)

        return outputBool.eraseToAnyPublisher()
    }
    
}
