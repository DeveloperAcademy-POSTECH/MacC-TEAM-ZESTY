//
//  AddPlaceSearchViewModel.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import Network

class AddPlaceSearchViewModel {
    
    enum Input {
        case searchBtnDidTap(placeName: String)
        case placeResultCellDidTap(kakaoPlace: KakaoPlace)
    }
    
    enum Output {
        case searchPlaceFail(error: Error)
        case searchPlaceDidSucceed(results: [KakaoPlace])
        case existingPlace
        case addSelectedPlaceFail(error: Error)
        case addSelectedPlaceDidSucceed(kakaoPlace: KakaoPlace)
    }
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private let useCase: AddPlaceUseCase
    
    private var searchResults: [KakaoPlace] = []
    
    init(useCase: AddPlaceUseCase = AddPlaceUseCase()) {
        self.useCase = useCase
        
    }
    
    // MARK: - transform : Input -> Output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .searchBtnDidTap(let placeName):
                self?.searchPlace(name: placeName)
            case .placeResultCellDidTap(let kakaoPlace):
                self?.selectPlaceToAdd(place: kakaoPlace)
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    private func searchPlace(name: String) {
        useCase.searchKakaoPlaces(with: name)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.searchPlaceFail(error: error))
                }
            } receiveValue: { [weak self] kakaoPlaces in
                self?.searchResults = kakaoPlaces
                self?.output.send(.searchPlaceDidSucceed(results: kakaoPlaces))
            }
            .store(in: &cancelBag)
    }
    
    private func selectPlaceToAdd(place: KakaoPlace) {
        
        useCase.checkRegisterdPlace(with: place.kakaoPlaceId)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.addSelectedPlaceFail(error: error))
                }
            } receiveValue: { [weak self] result in
                if result {
                    self?.output.send(.existingPlace)
                } else {
                    self?.output.send(.addSelectedPlaceDidSucceed(kakaoPlace: place))
                }
            }
            .store(in: &cancelBag)
    }
}
