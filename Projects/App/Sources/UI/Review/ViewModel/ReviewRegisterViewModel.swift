//
//  ReviewRegisterViewModel.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
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
        var image: String? = ""
        var evaluation: Evaluation = .soso
        var reviewer: String = ""
        var registeredAt: String = ""
        var category: String = ""
        var placeName: String = ""
        var placeAddress: String = ""
    }
    
    @Published var result = Result()
    private let isRegisterFail = PassthroughSubject<String, Never>() // alert 용
    
    // MARK: - LifeCycle
    
    init(useCase: ReviewRegisterUseCase = ReviewRegisterUseCase(),
         placeId: Int, placeName: String) {
        self.useCase = useCase
        self.placeId = placeId
        self.placeName = placeName
    }
    
}

extension ReviewRegisterViewModel {
    
    func registerReview() {
        useCase.registerReview(placeId: placeId,
                               menuName: menu,
                               image: image,
                               grade: evaluation)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    let errorMessage = self.errorMessage(for: error)
                    self.isRegisterFail.send(errorMessage)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] review in
                guard let self = self else { return }
                self.result = Result(image: review.image,
                                     evaluation: Evaluation(review.evaluation),
                                     reviewer: review.reviewer.nickname,
                                     registeredAt: Date.getStringToDate(review.createdAt).getDateToString(format: "yy.MM.dd"),
                                     category: review.place.category.name,
                                     placeName: review.place.name,
                                     placeAddress: review.place.address)
            }
            .store(in: &cancelBag)
    }
    
    private func errorMessage(for error: NetworkError) -> String {
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
