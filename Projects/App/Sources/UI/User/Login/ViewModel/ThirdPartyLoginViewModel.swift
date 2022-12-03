//
//  ThirdPartyLoginViewModel.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import AuthenticationServices
import Combine
import UIKit
import KakaoSDKUser

final class ThirdPartyLoginViewModel {
    
    private enum ThirdPartyProvider {
        case kakao
        case apple
    }
    
    private let useCase = UserLoginUseCase()
    private var kakaoAccessToken: String?
    private var appleIdentifier: String?
    private var provider: ThirdPartyProvider?
    var isUserAlreadyRegistered = false
    
    // Input
    private let checkUserRegisteredSubject = PassthroughSubject<String, Never>()
    private let publishAccessTokenSubject = PassthroughSubject<Bool, Never>()
    
    // Output
    let shouldSetNicknameSubject = PassthroughSubject<Bool, Never>()
    let shouldSetOrganizationSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        checkUserRegisteredSubject
            .sink { [weak self] userIdentifier in
                guard let self = self else { return }
                self.useCase.isAlreadyLogin(userIdentifier: userIdentifier)
            }
            .store(in: &cancelBag)
        
        publishAccessTokenSubject
            .sink { [weak self] _ in
                guard let self = self, let provider = self.provider else { return }
                switch provider {
                case .kakao:
                    guard let kakaoAccessToken = self.kakaoAccessToken else { return }
                    self.useCase.postKakaoAccessToken(accessToken: kakaoAccessToken)
                case .apple:
                    guard let appleIdentifier = self.appleIdentifier else { return }
                    self.useCase.postAppleUserIdentifier(userIdentifier: appleIdentifier)
                }
            }
            .store(in: &cancelBag)
        
        useCaseBinding()
    }
    
    private func useCaseBinding() {
        useCase.isUserAlreadyRegisteredSubject
            .sink { [weak self] isUserAlreadyRegistered in
                guard let self = self else { return }
                self.isUserAlreadyRegistered = isUserAlreadyRegistered
                self.publishAccessTokenSubject.send(true)
            }
            .store(in: &cancelBag)
        
        useCase.userRegisteredSubject
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.useCase.getUserProfile()
            }
            .store(in: &cancelBag)
        
        useCase.isUserProfileReceivedSubject
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.isUserAlreadyRegistered {
                    if  UserInfoManager.userInfo?.userNickname == nil {
                        self.shouldSetNicknameSubject.send(true)
                        return
                    }
                    let userOrganization = UserInfoManager.userInfo?.userOrganization
                    if userOrganization == nil {
                        self.shouldSetOrganizationSubject.send(true)
                        return
                    }
                    if UserInfoManager.userInfo?.userOrgName == nil, let orgID = userOrganization?.first {
                        UserInfoManager.shared.fetchOrganizationList(orgID: orgID)
                    }
                    self.shouldSetNicknameSubject.send(false)
                } else {
                    self.shouldSetNicknameSubject.send(true)
                }
            }
            .store(in: &cancelBag)
    }
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오 앱으로 로그인
            kakaoLoginWithApp()
        } else {
            // 카카오 계정으로 로그인
            kakaoLoginWithAccount()
        }
    }
    
    private func kakaoLoginWithApp() {
        UserApi.shared.loginWithKakaoTalk { [weak self](oauthToken, error) in
            guard let self = self else { return }
            if let error = error {
                print(error)
            } else {
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let accessToken = oauthToken?.accessToken, let userId = user?.id {
                            let userIdentifier = String(userId)
                            self.kakaoAccessToken = accessToken
                            self.provider = .kakao
                            self.checkUserRegisteredSubject.send(userIdentifier)
                        }
                    }
                }
            }
        }
    }
    
    private func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            guard let self = self else { return }
            if let error = error {
                print(error)
            } else {
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let accessToken = oauthToken?.accessToken, let userId = user?.id {
                            let userIdentifier = String(userId)
                            self.kakaoAccessToken = accessToken
                            self.provider = .kakao
                            self.checkUserRegisteredSubject.send(userIdentifier)
                        }
                    }
                }
            }
        }
    }
    
    func appleLogin(authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 애플 로그인으로 받아온 appleIDCredential 요소들
            let userIdentifier = appleIDCredential.user
            self.appleIdentifier = userIdentifier
            self.provider = .apple
            self.checkUserRegisteredSubject.send(userIdentifier)
            
        default:
            break
        }
    }
    
}
