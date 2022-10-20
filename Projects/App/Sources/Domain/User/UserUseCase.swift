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

        API.postSignUp(userDTO: userDTO)
            .sink { error in
                print(error)
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cancelBag)
    }
    
}
