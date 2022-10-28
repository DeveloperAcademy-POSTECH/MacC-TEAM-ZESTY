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
    @Published var image: String?
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

extension ReviewRegisterViewModel: ErrorMapper {
    
    func uploadImage(with image: UIImage?) {
        let imageData = image?.pngData()
        useCase.uploadImage(with: imageData)
        useCase.uploadResultSubject
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error.localizedString)
                    self.isRegisterFail.send(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] imageString in
                guard let self = self else { return }
                print("viewmodel: image upload success, urlstring: \(imageString)")
                self.image = imageString
            }
            .store(in: &cancelBag)

    }
    
    func registerReview() {
        $image
            .sink { [weak self] imageString in
                guard let self = self else { return }
                self.useCase.registerReview(placeId: self.placeId,
                                            menuName: self.menu,
                                            image: imageString,
                                            grade: self.evaluation)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .failure(let error):
                        print(error)
                        let errorMessage = self.errorMessage(for: error)
                        self.isRegisterFail.send(errorMessage)
                    case .finished:
                        break
                    }
                } receiveValue: { [weak self] review in
                    guard let self = self else { return }
                    var image: String?
                    if !review.image.isEmpty {
                        image = review.image[0]
                    }
                    self.result = Result(image: image,
                                         evaluation: Evaluation(review.evaluation),
                                         reviewer: review.reviewer.nickname,
                                         registeredAt: Date.getStringToDate(review.createdAt).getDateToString(format: "yy.MM.dd"),
                                         category: review.place.category.name,
                                             placeName: review.place.name,
                                             placeAddress: review.place.address)
                    }
                .store(in: &self.cancelBag)
            }
            .store(in: &cancelBag)

    }
    
}
