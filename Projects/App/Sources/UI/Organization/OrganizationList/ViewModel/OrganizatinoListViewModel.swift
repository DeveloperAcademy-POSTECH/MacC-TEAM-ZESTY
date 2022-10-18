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
    
    // Input
    private var organizationArray: [Organization] = []
    private var orgNameArray: [String] = []
    @Published var userTextInput: String = "" {
        didSet {
            searchingInput(userTextInput)
        }
    }
    
    // Output
    @Published var searchingArray: [String] = []
    
    init() {
        setData()
        setSearchingData()
    }
    
}

extension OrganizationListViewModel {
    // TODO: useCase로 바꾸기
    private func setData() {
        organizationArray = Organization.mockData
        orgNameArray = organizationArray.map { $0.name }
    }
    
    private func setSearchingData() {
        searchingArray = orgNameArray
    }
    
    private func searchingInput(_ input: String) {
        if input.isEmpty {
            searchingArray = orgNameArray
            return
        }
        if input.contains(" ") {
            let inputArray = input.components(separatedBy: " ")

            searchingArray = orgNameArray.filter { orgName in
                var haveOrgName = false
                for input in inputArray where orgName.contains(input) {
                        haveOrgName = true
                }
                return haveOrgName
            }
        } else {
            self.searchingArray = self.orgNameArray.filter { $0.contains(input) }
        }
    }
}
