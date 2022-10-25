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
        case viewDidLoad
        case searchBtnDidTap(placeName: String)
        case placeResultCellDidTap
    }
    
    enum Output {
        case serachPlaceFail(error: Error)
        case serachPlaceDidSucceed(results: [KakaoPlace])
        case existingPlace
        case addSelectedPlace
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
            case .viewDidLoad:
                print("viewdidload")
            case .searchBtnDidTap(let placeName):
                self?.searchPlace(name: placeName)
            case .placeResultCellDidTap:
                self?.routeTo()
                
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    private func searchPlace(name: String) {
        useCase.searchKakaoPlaces(with: name)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.serachPlaceFail(error: error))
                }
            } receiveValue: { [weak self] kakaoPlaces in
                self?.searchResults = kakaoPlaces
                self?.output.send(.serachPlaceDidSucceed(results: kakaoPlaces))
            }
            .store(in: &cancelBag)
    }
    
    private func selectPlaceToAdd(place: KakaoPlace) {
        
        // API
        
        // 이미 존재하는 경우
        
        // 등록이 가능한 경우
    }
      
    private func routeTo() {
        
    }
    
}
