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
    
    private let useCase = UserLoginUseCase()
    
    // Input
    private let publishAccessTokenSubject = PassthroughSubject<String, Never>()
    
    // Output
    let isUserRegisteredSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        publishAccessTokenSubject
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
                    self.publishAccessTokenSubject.send(accessToken)
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
                    self.publishAccessTokenSubject.send(accessToken)
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
            
            // 서버에 API 요청 보내기
//            UserAPI.postAccessToken(accessToken: "someToken")
//                .sink { error in
//                    switch error {
//                    case .failure(let error): print(error.localizedString)
//                    case .finished: break
//                    }
//                } receiveValue: { result in
//                    print("userToken: \(result.authToken)")
//                }
//                .store(in: &cancelBag)
            
        default:
            break
        }
    }
    
}
