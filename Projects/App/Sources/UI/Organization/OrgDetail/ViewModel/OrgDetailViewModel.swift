//
//  OrgDetailViewModel.swift
//  App
//
//  Created by Chanhee Jeong on 2022/11/07.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit

final class OrgDetailViewModel {
    
    // MARK: - Properties
    private let useCase: OrganizationDetailUseCase
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    private let orgId: Int
    
    // Output
    struct OrgDetailCounts {
        var friends: Int
        var places: Int
        var images: Int
    }
    
    @Published var orgDetailCounts = OrgDetailCounts(friends: 0, places: 0, images: 0)
    
    // MARK: - LifeCycle
    
    init(useCase: OrganizationDetailUseCase = OrganizationDetailUseCase(),
         orgId: Int) {
        self.useCase = useCase
        self.orgId = orgId
        fetchDetails()
    }
    
}

extension OrgDetailViewModel {
    func fetchDetails() {
        useCase.fetchOrganizationDetail(with: orgId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { [weak self] organization in
                self?.orgDetailCounts = OrgDetailCounts(friends: organization.memberCount,
                                                        places: organization.placeCount,
                                                        images: organization.imageCount)
            }
            .store(in: &cancelBag)
    }
}
