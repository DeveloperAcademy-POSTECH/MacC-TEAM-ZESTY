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
        case viewDidLoad
        case addReviewBtnDidTap
        case kakaoBtnDidTap
        case naverBtnDidTap
        case nextCursorDidTrigger
    }
    
    enum Output {
        case fetchPlaceInfoFail(error: Error)
        case fetchPlaceDidSucceed(place: Place)
        case fetchReviewListFail(error: Error)
        case fetchReviewListSucceed(list: [Review])
    }
    
    private var cursor = 1
    private let reviewWindow = 10 // 몇개단위로 가는지
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private let usecase: PlaceDetailUseCase
    
    init(placeDetailUseCase: PlaceDetailUseCase = PlaceDetailUseCase()) {
        self.usecase = placeDetailUseCase
    }
    
    // MARK: - transmutation : Input -> Output (transmute)
    func transmute(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.fetchPlaceInfo(id: 1)
            case .nextCursorDidTrigger:
                self?.loadMoreReviews()
            case .addReviewBtnDidTap:
                self?.routeTo()
            case .kakaoBtnDidTap:
                self?.openKakaoMap()
            case .naverBtnDidTap:
                self?.openNaverMap()

            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
    
    private func fetchPlaceInfo(id: Int) {
           
        // 할일: loadReviews
    }
    
    private func loadReviews() {
        
    }
    
    private func loadMoreReviews() {
        
    }
    
    private func openKakaoMap() {
        
    }
    
    private func openNaverMap() {
        
    }
    
    // 리뷰추가화면전환
    private func routeTo() {
        
    }
      
}
