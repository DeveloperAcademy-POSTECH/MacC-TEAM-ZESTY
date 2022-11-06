//
//  DomainSettingViewModel.swift
//  App
//
//  Created by 김태호 on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

final class DomainSettingViewModel {
    // input
    @Published var userEmail: String = ""
    
    // output
    @Published var isEmailEmpty = true
    @Published var isDuplicateEmail = false
    @Published var isButtonValid = false
    
    var orgDomain: String = ""
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $userEmail
            .map(checkEmailValid)
            .assign(to: \.isEmailEmpty, on: self)
            .store(in: &cancelBag)
    }
}

// MARK: - Logic

extension DomainSettingViewModel {
    
    private func checkEmailValid(email: String) -> Bool {
        return email.isEmpty
    }
    
}
