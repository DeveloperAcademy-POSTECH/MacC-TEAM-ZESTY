//
//  AddPlaceViewModel.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import Network

class AddPlaceViewModel {
    
    enum Input {
        case categoryViewDidLoad
        case categoryCellDidTap(category: Int)
        case addPlaceBtnDidTap
    }
    
    enum Output {
        case fetchCategoriesFail(error: Error)
        case fetchCategoriesDidSucceed(categories: [Category])
        case categoryCellSelected
        case addPlaceFail(error: Error)
        case addPlaceDidSucceed(place: PlaceResult)
    }
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private let useCase: AddPlaceUseCase
    
    private var kakaoPlace: KakaoPlace
    private var selectedCategory: Int = 0
    private var categories: [Category] = []
    
    init(useCase: AddPlaceUseCase = AddPlaceUseCase(), kakaoPlace: KakaoPlace) {
        self.useCase = useCase
        self.kakaoPlace = kakaoPlace
    }
    
    // MARK: - transform : Input -> Output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { [weak self] event in
            switch event {
            case .categoryViewDidLoad:
                self?.fetchCategories()
            case .categoryCellDidTap(let category):
                self?.selectedCategory = category
                self?.output.send(.categoryCellSelected)
            case .addPlaceBtnDidTap:
                self?.addNewPlace(place: self!.kakaoPlace,
                                  category: self!.selectedCategory)
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    
    private func fetchCategories() {
        useCase.fetchCategories()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.fetchCategoriesFail(error: error))
                }
            } receiveValue: { [weak self] categories in
                self?.categories = categories
                self?.output.send(.fetchCategoriesDidSucceed(categories: categories))
            }
            .store(in: &cancelBag)
    }
    
    private func addNewPlace(place: KakaoPlace, category: Int) {
        useCase.addNewPlace(with: place, category: category)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.addPlaceFail(error: error))
                }
            } receiveValue: { [weak self] placeResult in
                self?.output.send(.addPlaceDidSucceed(place: placeResult))
            }
            .store(in: &cancelBag)
    }
     
}
