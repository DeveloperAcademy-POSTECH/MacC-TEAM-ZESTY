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
    
    let useCase = UserUseCase()
    
    var user: User? = UserDefaults.standard.user
    var accessToken: String?
    
    // output
    @Published var isLoggedIn = false
    
    @MainActor
    func kakaoLogin() {
        Task {
            // 카카오 앱으로 로그인
            if UserApi.isKakaoTalkLoginAvailable() {
                isLoggedIn = await kakaoLoginWithApp()
            } else {
                // 카카오 계정으로 로그인
                isLoggedIn = await kakaoLoginWithAccount()
            }
            if isLoggedIn {
                guard let accessToken = self.accessToken else { return }
                useCase.postAccessTokenUser(accessToken: accessToken)
            }
        }
    }
    
    @MainActor
    private func kakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.accessToken = accessToken
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    private func kakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.accessToken = accessToken
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
