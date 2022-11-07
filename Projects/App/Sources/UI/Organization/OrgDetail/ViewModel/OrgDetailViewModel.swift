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
//    private let useCase: OrgDetailUseCase
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
    
    init(orgId: Int) {
        self.orgId = orgId
    }
    
}

extension OrgDetailViewModel {
    
}
