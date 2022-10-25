//
//  ReviewRegisterViewModel.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit.UIImage
import Network

final class ReviewRegisterViewModel {
    
    // MARK: - Properties
    
    private let useCase: ReviewRegisterUseCase
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    private let placeId: Int
    let placeName: String
    var evaluation: Evaluation = .soso
    var image: UIImage?
    var menu: String?
    
    // Output
    struct Result {
        var image: UIImage = UIImage()
        var reviewer: String = ""
        var registeredAt: String = ""
        var category: String = ""
        var placeName: String = ""
        var placeAddress: String = ""
    }
    
    @Published var result = Result()
    private let isRegisterFail = PassthroughSubject<Bool, Never>()
    
    // MARK: - LifeCycle
    
    init(useCase: ReviewRegisterUseCase = ReviewRegisterUseCase(),
         placeId: Int, placeName: String) {
        self.useCase = useCase
        self.placeId = placeId
        self.placeName = placeName
    }
    
}

extension ReviewRegisterViewModel {
    
//    func fetchReviewResult() {
//        useCase.registerReview(placeId: <#T##Int#>, grade: <#T##Evaluation#>)
//        useCase.reviewRegisterSubject
//            .sink { [weak self] _ in
//                guard let self = self else { return }
//                self.isRegisterFail.send(false)
//            } receiveValue: { [weak self] review in
//                guard let self = self else { return }
//                self.result = Result(reviewer: review.reviewer.nickname,
//                                     registeredAt: review.createdAt.getDateToString(format: "yy.mm.dd"),
//                                     category: "",
//                                     placeLocation: "")
//            }
//            .store(in: &cancelBag)
//    }
    
}
