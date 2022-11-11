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
    
    func checkEmailOverlaped() {
        let userEmail = getUserEmail()
        useCase.getEamilValidation(email: userEmail)
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
