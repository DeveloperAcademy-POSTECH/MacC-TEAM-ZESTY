//
//  OrgSearchingViewModel.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Combine

final class OrganizationListViewModel {
    
    // Input
    var organizationArray: [Organization] = []
    private var orgNameArray: [String] = []
    
    @Published var userTextInput: String = "" {
        didSet {
            searchingInput(userTextInput)
        }
    }
    
    //Output
    @Published var orgSearchingArray: [String] = []
    
    init() {
        setData()
    }
    
}

extension OrganizationListViewModel {
    private func setData() {
        organizationArray = Organization.mockData
        orgNameArray = organizationArray.map{ $0.name }
        orgSearchingArray = orgNameArray
    }
    
    private func searchingInput(_ input: String) {
        if input.isEmpty {
            orgSearchingArray = orgNameArray
        } else {
            self.orgSearchingArray = self.orgNameArray.filter { $0.contains(input) }
        }
    }
}
