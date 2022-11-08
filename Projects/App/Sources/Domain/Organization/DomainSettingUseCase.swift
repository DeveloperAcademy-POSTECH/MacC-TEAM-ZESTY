//
//  DomainSettingUseCase.swift
//  App
//
//  Created by 김태호 on 2022/11/07.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class DomainSettingUseCase {
    
    // output
    let isEmailOverlapedSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func postUserEmail(email: String, orgnization: Organization) {
        guard let authorization = KeyChainManager.read(key: .authToken) else { return }
        
        let userDTO = SignUpUserDTO(id: orgnization.id, email: email, organizationName: orgnization.name)

        UserAPI.postSignUp(authorization: authorization, userDTO: userDTO)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure(let error):
                    print(error.localizedString)
                    self.isEmailOverlapedSubject.send(true)
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.isEmailOverlapedSubject.send(false)
            }
            .store(in: &cancelBag)
    }
    
}
