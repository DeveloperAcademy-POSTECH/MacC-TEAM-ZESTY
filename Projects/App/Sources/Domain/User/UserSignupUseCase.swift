//
//  UsersignupUseCase.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserSignupUseCase {
    
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
    
}
