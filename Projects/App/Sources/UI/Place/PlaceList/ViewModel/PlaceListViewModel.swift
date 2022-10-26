//
//  PlaceListViewModel.swift
//  App
//
//  Created by 리아 on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

class PlaceListViewModel {
    
    // MARK: - Properties
    
    private let useCase: PlaceListUseCase
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    @Published var page: Int = 1
    
    // Output
    struct Result {
        var placeName: String
        var evaluationSum: EvaluationSum
        var reviews: [ReviewDTO]
        
        init(placeName: String = "",
             evaluationSum: EvaluationSum = EvaluationSum(good: 0, soso: 0, bad: 0),
             reviews: [ReviewDTO] = []) {
            self.placeName = placeName
            self.evaluationSum = evaluationSum
            self.reviews = reviews
        }
    }
    
    @Published var result: [Result] = []
    let isRegisterFail = PassthroughSubject<String, Never>() // alert 용
    
    // MARK: - LifeCycle
    
    init(useCase: PlaceListUseCase = PlaceListUseCase()) {
        self.useCase = useCase
    }
    
}

// MARK: - Functions

extension PlaceListViewModel: ErrorMapper {
    
    func bind() {
        useCase.fetchPlaceList(with: page)
            .sink { error in
                switch error {
                case .failure(let error):
                    let errorMessage = self.errorMessage(for: error)
                    self.isRegisterFail.send(errorMessage)
                case .finished: break
                }
            } receiveValue: { [weak self] placeListDTO in
                guard let self = self else { return }
                let placeList = placeListDTO.map { placeDTO in
                    Result(placeName: placeDTO.shopName,
                           evaluationSum: EvaluationSum(dto: placeDTO.evaluations),
                           reviews: placeDTO.reviewContent)
                }
                self.result = placeList
            }
            .store(in: &cancelBag)
    }
        
}

protocol ErrorMapper { }

extension ErrorMapper {
    
    func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .unauthorized, .forbidden:
            return "권한이 없습니다."
        case .serverError:
            return "서버에 문제가 생겼습니다. 다시 시도해주세요."
        case .unknown:
            return "알 수 없는 에러..🥲"
        default:
            return "문제가 발생했습니다. 제보해주시면 수정하도록 하겠습니다. 😂"
        }
    }
    
}
