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
    @Published var activatedField: UITextField?
    
    // Output
    @Published var isTextEmpty = true
    @Published var isKeyboardShown = false

    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $nickNameText
            .map(isEmpty)
            .assign(to: \.isTextEmpty, on: self)
            .store(in: &cancelBag)
        
        $activatedField
            .map(checkIsNotNil)
            .assign(to: \.isKeyboardShown, on: self)
            .store(in: &cancelBag)
    }
    
    private func isEmpty(to text: String) -> Bool {
        return text.isEmpty
    }
    
    private func checkIsNotNil(to textField: UITextField?) -> Bool {
        return textField != nil
    }
    
}
