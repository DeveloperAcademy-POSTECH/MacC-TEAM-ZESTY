//
//  PlaceDetailViewModel.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import Network

class PlaceDetailViewModel {
    
    enum Input {
        case viewDidLoad(placeId: Int)
        case addReviewBtnDidTap
    }
    
    enum Output {
        case fetchPlaceInfoFail(error: Error)
        case fetchPlaceDidSucceed(place: Place)
        case fetchReviewListFail(error: Error)
        case fetchReviewListSucceed(list: [Review])
    }
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private let useCase: PlaceDetailUseCase
    
    var place: Place?
    var reviews: [Review] = []
    
    init(placeDetailUseCase: PlaceDetailUseCase = PlaceDetailUseCase()) {
        self.useCase = placeDetailUseCase
    }
    
    // MARK: - transform : Input -> Output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad(let placeId):
                self?.fetchPlaceInfo(id: placeId)
                self?.fetchReviews()
            case .addReviewBtnDidTap:
                self?.routeTo()
                
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    
    private func fetchPlaceInfo(id: Int) {
        useCase.fetchPlaceDetail(with: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.fetchPlaceInfoFail(error: error))
                }
            } receiveValue: { [weak self] place in
                self?.place = place
                self?.output.send(.fetchPlaceDidSucceed(place: place))
            }
            .store(in: &cancelBag)
    }
    
    // 리뷰가져오기
    private func fetchReviews() {
        
    }
    
    // 리뷰추가화면전환
    private func routeTo() {
        // TO-DO: place id, name
    }
    
}
