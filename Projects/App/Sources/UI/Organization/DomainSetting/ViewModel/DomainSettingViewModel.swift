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
    
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    init(organization: Organization) {
        self.organization = organization
        bind()
    }
    
    func postUserEmail() {
        let userEmail = getUserEmail()
        useCase.postUserEmail(email: userEmail, orgnization: organization)
    }
    
    func getUserEmail() -> String {
        let userEamil: String = userInput + "@" + organization.domain
        return userEamil
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
                print(#function)
                if isEmailOverlaped {
                    self.shouldDisplayWarning = true
                }
                self.isEmailOverlapedSubject.send(isEmailOverlaped)
                
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
