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
    
    func fetchOrganizationList() -> AnyPublisher<[Organization], NetworkError> {
        return OrganizationAPI.fetchOrgList()
            .map { orgList in
                orgList.map { Organization(dto: $0) }
            }
            .eraseToAnyPublisher()
    }
    
}
