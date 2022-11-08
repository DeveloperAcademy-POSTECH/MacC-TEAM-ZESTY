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
    
    private let profileUseCase = UserProfileUseCase()
    private let changeNicknameUseCase = UserNicknameUseCase()
    
    private var cancelBag = Set<AnyCancellable>()
    
    // output
    let isUserLoggedOutSubject = PassthroughSubject<Bool, Never>()
    let isNickNameChangedSubject = PassthroughSubject<Bool, Never>()
    let changeNickNameButtonClicked = PassthroughSubject<Bool, Never>()
    
    let userNickname = UserInfoManager.userInfo?.userNickname ?? "unknown"
    
    func userLogout() {
        UserInfoManager.resetUserInfo()
        isUserLoggedOutSubject.send(true)
    }
    
    func userWithdrawl() {
        profileUseCase.deleteUser()
        KeyChainManager.delete(key: .authToken)
    }
    
    init() {
        profileUseCase.isUserDeletedSubject
            .sink { [weak self] _ in
                self?.userLogout()
            }
            .store(in: &cancelBag)
        
        changeNicknameUseCase.isNickNameChangedSubject
            .sink { [weak self] _ in
                self?.isNickNameChangedSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
}
