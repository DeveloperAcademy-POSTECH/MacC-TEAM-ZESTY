//
//  OrganizatinoListViewModel.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

final class OrganizationListViewModel {
    
    // MARK: - Properties
    
    private let useCase: OrganizationListUseCase
    
    private var orgArray: [Organization] = []
    private var orgNameArray: [String] = []
    
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    @Published var userTextInput: String = ""
    
    // Output
    @Published var searchedOrgArray: [String] = []
    let isRegisterFail = PassthroughSubject<String, Never>()
    
    // MARK: - LifeCycle
    
    init(useCase: OrganizationListUseCase = OrganizationListUseCase()) {
        self.useCase = useCase
        
        fetchOrganizationList()
        bind()
    }
}

// MARK: - Bind Fucntions
extension OrganizationListViewModel {
    private func bind() {
        $userTextInput
            .sink { [weak self] userTextInput in
                self?.searchInput(userTextInput)
            }
            .store(in: &cancelBag)
    }
}

// MARK: - Functions

extension OrganizationListViewModel: ErrorMapper {
    private func fetchOrganizationList() {
        useCase.fetchOrganizationList()
            .sink { [weak self] error in
                guard let self = self else { return }
                
                switch error {
                case .failure(let error):
                    let errorMessage = self.errorMessage(for: error)
                    self.isRegisterFail.send(errorMessage)
                case .finished: break
                }
            } receiveValue: { [weak self] orgList in
                guard let self = self else { return }
                self.orgArray = orgList
                self.orgNameArray = orgList.map { $0.name }
            }
            .store(in: &cancelBag)
    }
    
    private func searchInput(_ input: String) {
        if input.isEmpty {
            searchedOrgArray = []
            return
        }
        if input.contains(" ") {
            let inputArray = input.components(separatedBy: " ")

            searchedOrgArray = orgNameArray.filter { orgName in
                var haveOrgName = false
                for input in inputArray where orgName.contains(input) {
                        haveOrgName = true
                }
                return haveOrgName
            }
        } else {
            self.searchedOrgArray = self.orgNameArray.filter { $0.contains(input) }
        }
    }
}
