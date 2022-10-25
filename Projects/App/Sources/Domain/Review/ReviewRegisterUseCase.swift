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
        // TODO: userDefaults 에 유저 아이디 꼭!! 저장해야함
        UserDefaults.standard.userID = 6
        let user = UserDefaults.standard.userID ?? 6
        let reviewDTO = RegisterReviewDTO(placeId: placeId,
                                   menuName: menuName,
                                   image: "https://user-images.githubusercontent.com/73650994/197836640-616d1451-7ac9-492d-bf6e-d9d125f9ac44.png",
                                   grade: grade.rawValue,
                                   reviewer: user)
        
        return ReviewAPI.postReview(with: reviewDTO)
            .eraseToAnyPublisher()
    }
    
}
