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
        case viewDidLoad
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
    private let useCase: AddPlaceUseCase
    
    private var kakaoPlace: KakaoPlace
    private var place: Place?
    private var reviews: [Review] = []
    
    init(useCase: AddPlaceUseCase = AddPlaceUseCase(), kakaoPlace: KakaoPlace) {
        self.useCase = useCase
        self.kakaoPlace = kakaoPlace
    }
    
    // MARK: - transform : Input -> Output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
//                self?.fetchPlaceInfo(id: self?.placeId ?? -1)
//                self?.fetchReviews(id: self?.placeId ?? -1)
                print("viewdidload") // ✅
            case .addReviewBtnDidTap:
                self?.routeTo()
                
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    
//    private func fetchPlaceInfo(id: Int) {
//        useCase.fetchPlaceDetail(with: id)
//            .sink { [weak self] completion in
//                if case .failure(let error) = completion {
//                    self?.output.send(.fetchPlaceInfoFail(error: error))
//                }
//            } receiveValue: { [weak self] place in
//                self?.place = place
//                self?.output.send(.fetchPlaceDidSucceed(place: place))
//            }
//            .store(in: &cancelBag)
//    }
//
//    private func fetchReviews(id: Int) {
//        useCase.fetchReviewList(with: id)
//            .sink { [weak self] completion in
//                if case .failure(let error) = completion {
//                    self?.output.send(.fetchReviewListFail(error: error))
//                }
//            } receiveValue: { [weak self] reviews in
//                self?.reviews = reviews
//                self?.output.send(.fetchReviewListSucceed(list: reviews))
//            }
//            .store(in: &cancelBag)
//    }
    
    private func routeTo() {
        // let viewModel = ReviewRegisterViewModel(placeId: place?.id, placeName: place?.name)
        // EvaluationViewController(viewModel: viewModel)
    }
    

}
