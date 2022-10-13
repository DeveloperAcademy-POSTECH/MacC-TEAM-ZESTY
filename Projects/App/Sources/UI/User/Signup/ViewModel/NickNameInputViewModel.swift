//
//  NickNameInputViewModel.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import Combine

final class NickNameInputViewModel {
    
    // Input
    @Published var nickNameText = ""
    
    // Output
    @Published var isTextEmpty = true

    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $nickNameText
            .map(checkIsEmpty)
            .assign(to: \.isTextEmpty, on: self)
            .store(in: &cancelBag)
    }
    
    private func checkIsEmpty(to string: String) -> Bool {
        return string == ""
    }
}
