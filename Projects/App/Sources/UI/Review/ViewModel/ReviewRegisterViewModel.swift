//
//  ReviewRegisterViewModel.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

final class ReviewRegisterViewModel {
    
    private let useCase: ReviewRegisterUseCase
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(useCase: ReviewRegisterUseCase = ReviewRegisterUseCase()) {
        self.useCase = useCase
    }
    
}
