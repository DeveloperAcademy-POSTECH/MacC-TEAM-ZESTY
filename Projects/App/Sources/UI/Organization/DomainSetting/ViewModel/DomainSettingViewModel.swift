//
//  DomainSettingViewModel.swift
//  App
//
//  Created by 김태호 on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

final class DomainSettingViewModel {
    
    // MARK: - Properties
    
    let organization: Organization
    private let useCase = DomainSettingUseCase()
    
    // input
    @Published var userInput: String = ""
    
    // output
    @Published var isInputValid = false
    @Published var shouldDisplayWarning = false
    let isEmailOverlapedSubject = PassthroughSubject<Bool, Never>()
    let isCodeSendSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    init(organization: Organization) {
        self.organization = organization
        bind()
    }
    
    func sendCode() {
        let userEmail = getUserEmail()
        useCase.sendCode(email: userEmail)
    }
    
    func getUserEmail() -> String {
        let userEmail: String = userInput + "@" + organization.domain
        return userEmail
    }
}

// MARK: - Bind Fucntions

extension DomainSettingViewModel {
    
    private func bind() {
        $userInput
            .map(checkInputValid)
            .assign(to: \.isInputValid, on: self)
            .store(in: &cancelBag)
        
        $userInput
            .sink { [weak self] _ in
                if let self = self, self.shouldDisplayWarning {
                    self.shouldDisplayWarning = false
                }
            }
            .store(in: &cancelBag)
        
        // TODO: 서버의 API가 정리되어 있지 않아서 남겨둡니다. 추후에 이메일 중복 API가 만들어진다면 사용할 예정입니다
        useCase.isEmailOverlapedSubject
            .sink { [weak self] isEmailOverlaped in
                guard let self = self else { return }
                if isEmailOverlaped {
                    self.shouldDisplayWarning = true
                }
                self.isEmailOverlapedSubject.send(isEmailOverlaped)
                
            }
            .store(in: &cancelBag)
        
        useCase.isCodeSendSubject
            .sink { [weak self] isCodeSend in
                guard let self = self else { return }
                if isCodeSend {
                    self.isCodeSendSubject.send(isCodeSend)
                } else {
                    // TODO: 나중에 API가 수정되면 변경할 부분입니다
                    self.shouldDisplayWarning = true
                }
                
            }
            .store(in: &cancelBag)

    }
    
}

// MARK: - Logic

extension DomainSettingViewModel {
    
    private func checkInputValid(email: String) -> Bool {
        return !(email.isEmpty || email.contains(" "))
    }
    
}
