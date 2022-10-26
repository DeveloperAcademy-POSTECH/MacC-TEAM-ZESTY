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
        struct Review {
            var image: String?
            var menu: String?
        }
        
        var placeName: String
        var evaluationSum: EvaluationSum
        var review: Review
        
        init(placeName: String = "",
             evaluationSum: EvaluationSum = EvaluationSum(good: 0, soso: 0, bad: 0),
             review: Review = Review()
             ) {
            self.placeName = placeName
            self.evaluationSum = evaluationSum
            self.review = review
        }
    }
    
    @Published var result = Result()
    let isRegisterFail = PassthroughSubject<String, Never>() // alert 용
    
    // MARK: - LifeCycle
    
    init(useCase: PlaceListUseCase = PlaceListUseCase()) {
        self.useCase = useCase
    }
    
}

// MARK: - Functions

extension PlaceListViewModel {
    
}
