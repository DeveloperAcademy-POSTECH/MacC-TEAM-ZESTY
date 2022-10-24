//
//  OrganizationUseCase.swift
//  App
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class OrganizationListUseCase {
    
    private var cancelBag = Set<AnyCancellable>()
    
    func fetchOrganizationList() {
        OrganizationAPI.fetchOrgList()
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { orgListDTO in
                let orgList = orgListDTO.map { Organization(dto: $0) }
            }
            .store(in: &cancelBag)
    }
    
}
