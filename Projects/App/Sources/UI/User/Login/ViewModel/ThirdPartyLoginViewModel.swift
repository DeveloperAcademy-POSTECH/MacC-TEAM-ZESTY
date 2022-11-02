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
    private var identifier: String?
    private var provider: ThirdPartyProvider?
    private var userName = UserDefaults.standard.userName
    var isUserAlreadyRegistered = false
    
    // Input
    private let checkUserRegisteredSubject = PassthroughSubject<String, Never>()
    private let isUserRegisteredSubject = PassthroughSubject<Bool, Never>()
    private let publishAccessTokenSubject = PassthroughSubject<String, Never>()
    
    // Output
    let shouldSetNicknameSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        checkUserRegisteredSubject
            .sink { [weak self] userIdentifier in
                guard let self = self else { return }
                print(userIdentifier)
                self.useCase.isAlreadyLogin(userIdentifier: userIdentifier)
            }
            .store(in: &cancelBag)
        
        publishAccessTokenSubject
            .sink { [weak self] accessToken in
                guard let self = self else { return }
                guard let userIdentifier = self.identifier else { return }
                guard let provider = self.provider else { return }
                switch provider {
                case .kakao:
                    self.useCase.postKakaoAccessToken(accessToken: userIdentifier)
                case .apple:
                    self.useCase.postAppleUserIdentifier(userIdentifier: userIdentifier)
                }
            }
            .store(in: &cancelBag)
        
        useCase.isUserAlreadyRegisteredSubject
            .sink { [weak self] isUserAlreadyRegistered in
                guard let self = self else { return }
                guard let identifier = self.identifier else { return }
                print(isUserAlreadyRegistered)
                self.isUserAlreadyRegistered = isUserAlreadyRegistered
                self.publishAccessTokenSubject.send(identifier)
            }
            .store(in: &cancelBag)
        
        useCase.isUserRegisteredSubject
            .sink { [weak self] isUserRegistered in
                guard let self = self else { return }
                self.isUserRegisteredSubject.send(isUserRegistered)
            }
            .store(in: &cancelBag)
        
        isUserRegisteredSubject
            .sink { [weak self] isUserRegistered in
                guard let self = self else { return }
                if !isUserRegistered {
                    return
                }
                if self.userName == nil {
                    self.shouldSetNicknameSubject.send(true)
                    return
                }
                if !self.isUserAlreadyRegistered {
                    self.shouldSetNicknameSubject.send(true)
                } else if self.isUserAlreadyRegistered {
                    self.shouldSetNicknameSubject.send(false)
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
                if let accessToken = oauthToken?.accessToken {
                    self.identifier = accessToken
                    self.provider = .kakao
                    self.checkUserRegisteredSubject.send(accessToken)
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
                if let accessToken = oauthToken?.accessToken {
                    self.identifier = accessToken
                    self.provider = .kakao
                    self.checkUserRegisteredSubject.send(accessToken)
                }
            }
        }
    }
    
    func appleLogin(authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 애플 로그인으로 받아온 appleIDCredential 요소들
            let userIdentifier = appleIDCredential.user
            
            print("userIdentifier: \(userIdentifier)")
            
            self.identifier = userIdentifier
            self.provider = .apple
            self.checkUserRegisteredSubject.send(userIdentifier)
            
        default:
            break
        }
    }
    
}
