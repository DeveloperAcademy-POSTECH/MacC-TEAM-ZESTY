//
//  SearchPlaceViewModel.swift
//  App
//
//  Created by Chanhee Jeong on 2022/11/03.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit
import Network

class SearchPlaceViewModel {
    
    enum Input {
        case searchBtnDidTap(placeName: String)
        case placeResultCellDidTap(place: Place)
    }
    
    enum Output {
        case searchPlaceFail(error: Error)
        case searchPlaceDidSucceed(results: [Place])
        case existingPlace
        case routeToSelectedPlace(placeId: Int)
    }
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private let useCase: PlaceSearchUseCase
    
    private var searchResults: [Place] = []
    
    init(useCase: PlaceSearchUseCase = PlaceSearchUseCase()) {
        self.useCase = useCase
        
    }
    
    // MARK: - transform : Input -> Output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .searchBtnDidTap(let placeName):
                self?.searchPlace(name: placeName)
            case .placeResultCellDidTap(let place):
                self?.selectPlaceToRoute(place: place)
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    private func searchPlace(name: String) {
        useCase.searchPlaces(with: name)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.searchPlaceFail(error: error))
                }
            } receiveValue: { [weak self] places in
                self?.searchResults = places
                self?.output.send(.searchPlaceDidSucceed(results: places))
            }
            .store(in: &cancelBag)
    }
    
    private func selectPlaceToRoute(place: Place) {
        output.send(.routeToSelectedPlace(placeId: place.id))
    }
}
