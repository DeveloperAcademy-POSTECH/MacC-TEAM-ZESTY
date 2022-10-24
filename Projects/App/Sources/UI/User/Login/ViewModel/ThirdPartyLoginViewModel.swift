//
//  ThirdPartyLoginViewModel.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import KakaoSDKUser

final class ThirdPartyLoginViewModel {
    
    private let useCase = UserLoginUseCase()
    private var accessToken: String?
    
    // Input
    private let isLoggedInSubject = PassthroughSubject<Bool, Never>()
    
    // Output
    let isUserRegisteredSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        isLoggedInSubject
            .sink { [weak self] isLoggedIn in
                guard let self = self else { return }
                if isLoggedIn {
                    self.postTokenToServer()
                }
            }
            .store(in: &cancelBag)
        
        useCase.isUserRegisteredSubject
            .sink { [weak self] isUserRegistered in
                guard let self = self else { return }
                self.isUserRegisteredSubject.send(isUserRegistered)
            }
            .store(in: &cancelBag)
    }
    
    private func postTokenToServer() {
        guard let accessToken = accessToken else { return }
        useCase.postAccessTokenUser(accessToken: accessToken)
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
                    self.accessToken = accessToken
                    self.isLoggedInSubject.send(true)
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
                    self.accessToken = accessToken
                    self.isLoggedInSubject.send(true)
                }
            }
        }
    }
}