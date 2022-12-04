//
//  UserInfoManagerUseCase.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/12/04.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation
import Network

final class UserInfoManagerUseCase {
    
    func fetchOrganizationList() -> AnyPublisher<[Organization], NetworkError> {
        return OrganizationAPI.fetchOrgList()
            .map { orgList in
                orgList.map { Organization(dto: $0) }
            }
            .eraseToAnyPublisher()
    }
    
}
