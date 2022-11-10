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
    let isCodeSendSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    func sendCode(email: String) {
        UserAPI.postSendCode(email: email)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure(let error):
                    print(error.localizedString)
                    self.isCodeSendSubject.send(false)
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.isCodeSendSubject.send(true)
            }
            .store(in: &cancelBag)

    }
    
}
