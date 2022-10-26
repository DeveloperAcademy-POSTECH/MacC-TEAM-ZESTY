//
//  PlaceListViewModel.swift
//  App
//
//  Created by 리아 on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

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

extension PlaceListViewModel {
    
}
