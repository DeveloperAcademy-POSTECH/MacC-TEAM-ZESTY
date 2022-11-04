//
//  ProfileViewModel.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/11/04.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit

final class ProfileViewModel {
    
    private let useCase = UserProfileUseCase()
    
    private var cancelBag = Set<AnyCancellable>()
    
    let isUserLoggedOutSubject = PassthroughSubject<Bool, Never>()
    
    func userLogout() {
        UserDefaults.standard.resetUserInfo()
        isUserLoggedOutSubject.send(true)
    }
    
    func userWithdrawl() {
        useCase.deleteUser()
    }
    
    init() {
        useCase.isUserDeletedSubject
            .sink { [weak self] _ in
                self?.userLogout()
            }
            .store(in: &cancelBag)
    }
    
}
