//
//  UserLoginUseCase.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserLoginUseCase {
    
    // output
    let isUserRegisteredSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func postAccessTokenUser(accessToken: String) {
        UserAPI.postAccessToken(accessToken: accessToken)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] userOauthDTO in
                guard let self = self else { return }
                self.isUserRegisteredSubject.send(true)
                UserDefaults.standard.authToken = userOauthDTO.authToken
            }
            .store(in: &cancelBag)
    }
    
}
