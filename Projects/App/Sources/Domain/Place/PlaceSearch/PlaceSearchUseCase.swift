//
//  PlaceSearchUseCase.swift
//  App
//
//  Created by Chanhee Jeong on 2022/11/03.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation
import Network

protocol PlaceSearchUseCaseType {
    func searchPlaces(with placeName: String) -> AnyPublisher<[Place], Error>
}

final class PlaceSearchUseCase: PlaceSearchUseCaseType {
    
    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<[Place], Error> = .init()
    
    func searchPlaces(with placeName: String) -> AnyPublisher<[Place], Error> {
        
//        TODO: ORG-ID 넣고 교체 필요
        let orgId = UserInfoManager.userInfo?.userOrganization[0] ?? 400
        
        PlaceAPI.fetchSearchPlaceResults(orgId: orgId, placeName: placeName)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] placeSearchResultDTO in
                let searchResults = placeSearchResultDTO.map {
                    Place(placeSearchResultDTO: $0)
                }
                self?.output.send(searchResults)
            }
            .store(in: &cancelBag)

        return output.eraseToAnyPublisher()
        
    }
    
}
