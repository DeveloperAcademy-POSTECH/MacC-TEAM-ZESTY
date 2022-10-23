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
    
    // output
    let isNickNameOverlapedSubject = PassthroughSubject<Bool, Never>()
    let isUserRegisteredSubject = PassthroughSubject<Bool, Never>()
    
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
                UserDefaults.standard.authToken = userOauthDTO.authToken
            }
            .store(in: &cancelBag)
    }
    
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
        guard let authorization = UserDefaults.standard.authToken else { return }
        UserAPI.putNickname(authorization: authorization, nickname: nickname)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                UserDefaults.standard.userName = nickname
                self.isUserRegisteredSubject.send(true)
                print("useCase isUserRegistered send true")
            }
            .store(in: &cancelBag)
    }
    
}
