//
//  UsersignupUseCase.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserSignupUseCase {
    
    // output
    let isNickNameOverlapedSubject = PassthroughSubject<Bool, Never>()
    let isNickNameChangedSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func getNicknameValidationUser(nickname: String) {
        UserAPI.getNicknameValidation(nickname: nickname)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure(let error):
                    print(error.localizedString)
                    self.isNickNameOverlapedSubject.send(true)
                case .finished: break
                }
            } receiveValue: { _ in
                self.isNickNameOverlapedSubject.send(false)
            }
            .store(in: &cancelBag)
    }
    
    func putNicknameUser(nickname: String) {
        guard let authorization = KeyChainManager.read(key: .authToken) else { return }
        UserAPI.putNickname(authorization: authorization, nickname: nickname)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                UserInfoManager.userInfo?.userNickname = nickname
                self.isNickNameChangedSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
}
