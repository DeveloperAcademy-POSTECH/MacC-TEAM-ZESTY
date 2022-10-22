//
//  UserUseCase.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserUseCase {
    
    private var cancelBag = Set<AnyCancellable>()

    func postSignUpUser() {
        let userDTO = SignUpUserDTO(id: 1, email: "tmdgusya@suwon.ac.kr", organizationName: "수원대학교")

        UserAPI.postSignUp(userDTO: userDTO)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cancelBag)
    }
    
    func postAccessTokenUser(accessToken: String) {
        UserAPI.postAccessToken(accessToken: accessToken)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { userOauthDTO in
                UserDefaults.standard.user = User(id: 1, social: .kakao, authToken: userOauthDTO.authToken)
            }
            .store(in: &cancelBag)
    }
    
}
