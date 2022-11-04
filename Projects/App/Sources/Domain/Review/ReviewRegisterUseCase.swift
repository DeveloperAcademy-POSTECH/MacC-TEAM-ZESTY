//
//  ReviewRegisterUseCase.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class ReviewRegisterUseCase {
    
    private let uploadManager = AWSS3ImageManager()
    private var cancelBag = Set<AnyCancellable>()
    let uploadResultSubject = PassthroughSubject<String, ImageUploadError>()
    
}

extension ReviewRegisterUseCase {
    
    func uploadImage(with data: Data?) {
        uploadManager.requestUpload(data: data)
        
        uploadManager.uploadResultSubject
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error.localizedString)
                    self.uploadResultSubject.send(completion: .failure(error))
                case .finished: break
                }
            } receiveValue: { [weak self] imageString in
                guard let self = self else { return }
                self.uploadResultSubject.send(imageString)
            }
            .store(in: &cancelBag)

    }
    
    func registerReview(placeId: Int,
                        menuName: String? = nil,
                        image: String? = nil,
                        grade: Evaluation) -> AnyPublisher<ReviewDetailDTO, NetworkError> {
        // TODO: userDefaults 에 유저 아이디 꼭!! 저장해야함
        UserDefaults.standard.userID = 11
        let user = UserDefaults.standard.userID ?? 11
        let reviewDTO = RegisterReviewDTO(placeId: placeId,
                                   menuName: menuName,
                                   image: image,
                                   grade: grade.rawValue,
                                   reviewer: user)
        
        return ReviewAPI.postReview(with: reviewDTO)
            .eraseToAnyPublisher()
    }
    
}
