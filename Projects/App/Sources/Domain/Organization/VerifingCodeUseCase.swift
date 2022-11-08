//
//  VerifingCodeUseCase.swift
//  App
//
//  Created by 김태호 on 2022/11/08.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class VerifingCodeUseCase {
    
    // output
    let isCodeValidSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func postOTPCode(email: String, code: String, organization: Organization) {
        let codeDTO = VerifyCodeDTO(id: organization.id, email: email, code: code)
        
        UserAPI.postVerifyCode(codeDTO: codeDTO)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure(let error):
                    print(error.localizedString)
                    self.isCodeValidSubject.send(false)
                case .finished: break
                }
            } receiveValue: {[weak self] _ in
                guard let self = self else { return }
                self.isCodeValidSubject.send(true)
            }
            .store(in: &cancelBag)
    }
    
}
