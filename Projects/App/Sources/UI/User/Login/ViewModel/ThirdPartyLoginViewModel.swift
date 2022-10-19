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
        }
    }
    
    @MainActor
    private func kakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(_, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    private func kakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(_, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
