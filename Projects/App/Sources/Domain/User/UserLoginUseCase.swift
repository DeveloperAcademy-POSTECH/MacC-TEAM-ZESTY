//
//  UserLoginUseCase.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserLoginUseCase {
    
    // output
    let userRegisteredSubject = PassthroughSubject<Bool, Never>()
    let isUserAlreadyRegisteredSubject = PassthroughSubject<Bool, Never>()
    let isUserProfileReceivedSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func isAlreadyLogin(userIdentifier: String) {
        UserAPI.isAlreadyLogin(userIdentifier: userIdentifier)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] isUserAlreadyRegistered in
                guard let self = self else { return }
                self.isUserAlreadyRegisteredSubject.send(isUserAlreadyRegistered)
            }
            .store(in: &cancelBag)
    }
    
    func postKakaoAccessToken(accessToken: String) {
        UserAPI.postKakaoAccessToken(accessToken: accessToken)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] userOauthDTO in
                guard let self = self else { return }
                KeyChainManager.create(key: .authToken, token: userOauthDTO.authToken)
                self.userRegisteredSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
    func postAppleUserIdentifier(userIdentifier: String) {
        UserAPI.postAppleUserIdentifier(userIdentifier: userIdentifier)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] userOauthDTO in
                guard let self = self else { return }
                KeyChainManager.create(key: .authToken, token: userOauthDTO.authToken)
                self.userRegisteredSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
    func getUserProfile() {
        guard let authorization = KeyChainManager.read(key: .authToken) else { return }
        UserAPI.getUserProfile(authorization: authorization)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] userProfileDTO in
                guard let self = self else { return }
                UserInfoManager.userInfo = UserInfoManager.UserInfo(authIdentifier: userProfileDTO.authIdentifier, userNickname: userProfileDTO.nickname, userID: userProfileDTO.id, userOrganization: userProfileDTO.organization)
                self.isUserProfileReceivedSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
}
