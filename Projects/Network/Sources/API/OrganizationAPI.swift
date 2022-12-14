//
//  OrganizationAPI.swift
//  Network
//
//  Created by 리아 on 2022/10/21.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

public struct OrganizationAPI {
    
    static let networkService = NetworkService()
    
    public static func fetchOrgList() -> AnyPublisher<OrganizationListDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let endpoint = Endpoint(path: "/api/organizations", headers: header)
        
        return networkService.request(with: endpoint, responseType: OrganizationListDTO.self)
    }
    
    public static func fetchOrgDetail(orgId: Int) -> AnyPublisher<OrgDetailDTO, NetworkError> {
        let header = ["Content-Type": "application/json"]
        let query = ["orgNo": "\(orgId)"]
        let endpoint = Endpoint(path: "/api/organizations/static", queryParams: query, headers: header)
        
        return networkService.request(with: endpoint, responseType: OrgDetailDTO.self)
    }

}
