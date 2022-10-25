//
//  ReviewRegisterUseCase.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import UIKit.UIImage
import Network

final class ReviewRegisterUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    
}

extension ReviewRegisterUseCase {
    
    func registerReview(placeId: Int,
                        menuName: String? = nil,
                        image: UIImage? = nil,
                        grade: Evaluation) -> AnyPublisher<ReviewDetailDTO, NetworkError> {
        // TODO: userdefaults
        let user = 0
        let reviewDTO = RegisterReviewDTO(placeId: placeId,
                                   menuName: menuName,
                                   image: image?.pngData()?.base64EncodedString(),
                                   grade: grade.rawValue,
                                   reviewer: user)
        
        return ReviewAPI.postReview(with: reviewDTO)
            .eraseToAnyPublisher()
    }
    
}
