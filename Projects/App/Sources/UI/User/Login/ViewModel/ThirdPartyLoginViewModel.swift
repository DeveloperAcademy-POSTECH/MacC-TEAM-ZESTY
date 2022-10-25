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
    
    // Input
    private let isLoggedInSubject = PassthroughSubject<String, Never>()
    
    // Output
    let isUserRegisteredSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        isLoggedInSubject
            .sink { [weak self] accessToken in
                guard let self = self else { return }
                self.useCase.postAccessTokenUser(accessToken: accessToken)
            }
            .store(in: &cancelBag)
        
        useCase.isUserRegisteredSubject
            .sink { [weak self] isUserRegistered in
                guard let self = self else { return }
                self.isUserRegisteredSubject.send(isUserRegistered)
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
                    self.isLoggedInSubject.send(accessToken)
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
                    self.isLoggedInSubject.send(accessToken)
                }
            }
        }
    }
}
