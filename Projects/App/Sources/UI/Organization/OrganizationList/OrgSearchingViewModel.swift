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
    @Published var userTextInput: String = "" {
        didSet {
            if userTextInput.count > 0 {
                self.orgNameArray = orgNameArray.filter { $0.contains(userTextInput) }
            } else {
                setData()
                return
            }
        }
    }
    
    //Output
    @Published var orgNameArray: [String] = []
    
    init() {
        setData()
    }
    
}

extension OrganizationListViewModel {
    private func setData() {
        organizationArray = Organization.mockData
        orgNameArray = organizationArray.map{ $0.name }
    }
}
