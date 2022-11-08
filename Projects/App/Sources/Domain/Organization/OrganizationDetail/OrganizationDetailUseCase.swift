//
//  OrganizationDetailUseCase.swift
//  App
//
//  Created by Chanhee Jeong on 2022/11/07.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation
import Network

protocol OrganizationDetailUseCaseType {
    func fetchOrganizationDetail(with orgId: Int) -> AnyPublisher<Organization, Error>
}

final class OrganizationDetailUseCase: OrganizationDetailUseCaseType {
    
    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<Organization, Error> = .init()

    func fetchOrganizationDetail(with orgId: Int) -> AnyPublisher<Organization, Error> {
        OrganizationAPI.fetchOrgDetail(orgId: orgId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] orgDetailDTO in
                let org = Organization(id: orgId,
                                       name: "",
                                       domain: "",
                                       memberCount: orgDetailDTO.countOfWithFriends,
                                       imageCount: orgDetailDTO.countOfUploadedReviewPhoto,
                                       placeCount: orgDetailDTO.countOfRegisteredPlaceByOrg)
                self?.output.send(org)
            }
            .store(in: &cancelBag)

        return output.eraseToAnyPublisher()
    }
}
