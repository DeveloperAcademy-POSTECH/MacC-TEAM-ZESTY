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
    
    private var organizationArray: [Organization] = []
    private var orgNameArray: [String] = []
    
    // Input
    @Published var userTextInput: String = "" {
        didSet {
            searchInput(userTextInput)
        }
    }
    
    // Output
    @Published var searchedOrgArray: [String] = []
    
    init() {
        setData()
        setInitialSearchedArray()
    }
    
}

extension OrganizationListViewModel {
    // TODO: useCase로 바꾸기
    private func setData() {
        organizationArray = Organization.mockData
        orgNameArray = organizationArray.map { $0.name }
    }
    
    private func setInitialSearchedArray() {
        searchedOrgArray = orgNameArray
    }
    
    private func searchInput(_ input: String) {
        if input.isEmpty {
            setInitialSearchedArray()
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
