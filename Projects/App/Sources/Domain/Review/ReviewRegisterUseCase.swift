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
import UIKit.UIImage

final class ReviewRegisterUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    let uploadResultSubject = PassthroughSubject<String, ImageUploadError>()
    
    init() {
        bind()
    }
    
}

extension ReviewRegisterUseCase {

    private func bind() {
        AWSS3ImageManager.shared.uploadResultSubject
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
    
    func uploadImage(with image: UIImage?) {
        let imageData = image?.jpegData(compressionQuality: 0.2)
        
        AWSS3ImageManager.shared.requestUpload(data: imageData)
    }
    
    func registerReview(placeId: Int,
                        menuName: String? = nil,
                        image: String? = nil,
                        grade: Evaluation) -> AnyPublisher<ReviewDetailDTO, NetworkError> {
        // TODO: userDefaults 에 유저 아이디 꼭!! 저장해야함
        UserInfoManager.userInfo?.userID = 11
        let user = UserInfoManager.userInfo?.userID ?? 11
        let reviewDTO = RegisterReviewDTO(placeId: placeId,
                                   menuName: menuName,
                                   image: image,
                                   grade: grade.rawValue,
                                   reviewer: user)
        
        return ReviewAPI.postReview(with: reviewDTO)
            .eraseToAnyPublisher()
    }
    
}
