//
//  UserProfileUseCase.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/11/04.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserProfileUseCase {
    
    // output
    let isUserDeletedSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func deleteUser() {
        guard let authorization = KeyChainManager.read(key: .authToken) else { return }
        UserAPI.deleteUser(authorization: authorization)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { _ in
                self.isUserDeletedSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
}
