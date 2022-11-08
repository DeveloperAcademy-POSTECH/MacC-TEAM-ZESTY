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
    var menu: String?
    let imageSubject = PassthroughSubject<String, Error>()
    
    // Output
    struct Result {
        var image: URL?
        var evaluation: Evaluation = .soso
        var reviewer: String = ""
        var registeredAt: String = ""
        var category: String = ""
        var placeName: String = ""
        var placeAddress: String = ""
    }
    
    let result = PassthroughSubject<Result, Never>()
    let isRegisterFail = PassthroughSubject<String, Never>() // alert 용
    
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
        useCase.uploadImage(with: image)
        
        useCase.uploadResultSubject
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error.localizedString)
                    let errorMessage = self.uploadErrorMessage(for: error)
                    self.isRegisterFail.send(errorMessage)
                case .finished: break
                }
            } receiveValue: { [weak self] imageString in
                guard let self = self else { return }
                self.imageSubject.send(imageString)
            }
            .store(in: &cancelBag)

    }
    
    func registerReview() {
        imageSubject
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.registerReview()
            } receiveValue: { [weak self] imageString in
                guard let self = self else { return }
                self.registerReview(with: imageString)
            }
            .store(in: &cancelBag)
    }
    
    private func registerReview(with imageString: String? = nil) {
        useCase.registerReview(placeId: placeId,
                                    menuName: menu,
                                    image: imageString,
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
            
            // TODO: ReviewDTO image 배열 -> String으로 바뀌면 수정 예정
            var imageURL: URL?
            if !review.image.isEmpty {
                imageURL = URL(string: review.image[0] ?? "")
            }
            let result = Result(image: imageURL,
                                evaluation: Evaluation(review.evaluation),
                                reviewer: review.reviewer.nickname,
                                registeredAt: Date.getStringToDate(review.createdAt).getDateToString(format: "yy.MM.dd"),
                                category: review.place.category.name,
                                placeName: review.place.name,
                                placeAddress: review.place.address)
            self.result.send(result)
        }
        .store(in: &cancelBag)
    }
    
}
