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
    
    private let organization: Organization
    private let useCase = DomainSettingUseCase()
    
    // input
    @Published var userInput: String = ""
    
    // output
    @Published var isInputValid = true
    @Published var shouldDisplayWarning = false
    let isEmailOverlapedSubject = PassthroughSubject<Bool, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(organization: Organization) {
        self.organization = organization
        
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
    
    func getOrgDomain() -> String {
        return organization.domain
    }
    
    func postUserEmail() {
        let userEmail: String = userInput + "@" + organization.domain
        useCase.postUserEmail(email: userEmail, orgnization: organization)
    }
}

// MARK: - Logic

extension DomainSettingViewModel {
    
    private func checkInputValid(email: String) -> Bool {
        return email.isEmpty || email.contains(" ")
    }
    
}
