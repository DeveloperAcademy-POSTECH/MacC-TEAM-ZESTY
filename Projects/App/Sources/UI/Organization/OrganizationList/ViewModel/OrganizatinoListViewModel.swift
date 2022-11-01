//
//  OrganizatinoListViewModel.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Combine

final class OrganizationListViewModel {
    
    private var orgArray: [Organization] = []
    private var orgNameArray: [String] = []
    
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    @Published var userTextInput: String = ""
    
    // Output
    @Published var searchedOrgArray: [String] = []
    
    init() {
        setData()
//        setInitialSearchedArray()
        
        $userTextInput
            .sink { [weak self] userTextInput in
                self?.searchInput(userTextInput)
            }
            .store(in: &cancelBag)
    }
    
}

extension OrganizationListViewModel {
    // TODO: useCase로 바꾸기
    private func setData() {
        orgArray = Organization.mockData
        orgNameArray = orgArray.map { $0.name }
    }
    
//    private func setInitialSearchedArray() {
//        searchedOrgArray = orgNameArray
//    }
    
    private func searchInput(_ input: String) {
        if input.isEmpty {
//            setInitialSearchedArray()
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
