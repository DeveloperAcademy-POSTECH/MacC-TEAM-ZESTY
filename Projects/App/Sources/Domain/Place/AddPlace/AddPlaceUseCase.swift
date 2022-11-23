//
//  AddPlaceUseCase.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

protocol AddPlaceUseCaseType {
    func searchKakaoPlaces(with name: String) -> AnyPublisher<[KakaoPlace], Error>
//    func checkRegisterdPlace(with kakaoPlaceId: Int) -> AnyPublisher<Bool, Error>
    func checkRegisterdPlace(with kakaoPlaceId: Int) -> AnyPublisher<Bool, AddPlaceError>
    func fetchCategories() -> AnyPublisher<[Category], Error>
    func addNewPlace(with place: KakaoPlace, category: Int) -> AnyPublisher<PlaceResult, Error>
}

final class AddPlaceUseCase: AddPlaceUseCaseType {

    private var cancelBag = Set<AnyCancellable>()
    private let output: PassthroughSubject<[KakaoPlace], Error> = .init()
    private let outputBool: PassthroughSubject<Bool, Error> = .init()
    private let outputCategories: PassthroughSubject<[Category], Error> = .init()
    private let outputPlace: PassthroughSubject<PlaceResult, Error> = .init()

    func addNewPlace(with place: KakaoPlace, category: Int) -> AnyPublisher<PlaceResult, Error> {
        
        let user = UserInfoManager.userInfo?.userID ?? 64
        let org = UserInfoManager.userInfo?.userOrganization[0] ?? 400
        let placeDTO = PlacePostDTO(address: place.address,
                                    name: place.placeName,
                                    latitude: place.lat,
                                    longitude: place.lon,
                                    category: category,
                                    organizations: org,
                                    creator: user,
                                    placeImage: "",
                                    kakaoPlaceID: place.kakaoPlaceId)
        
        PlaceAPI.postPlace(with: placeDTO)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] placeResDTO in
                let place = PlaceResult(dto: placeResDTO)
                self?.outputPlace.send(place)
            }.store(in: &cancelBag)
   
        return outputPlace.eraseToAnyPublisher()
    }
 
    func searchKakaoPlaces(with name: String) -> AnyPublisher<[KakaoPlace], Error> {
        PlaceAPI.getKakaoPlaceList(placeName: name)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] kakaoPlaceListDTO in
                let searchResults = kakaoPlaceListDTO.map {
                    KakaoPlace(dto: $0)
                }
                self?.output.send(searchResults)
            }
            .store(in: &cancelBag)

        return output.eraseToAnyPublisher()

    }
    
    /* 임시 삭제
    func checkRegisterdPlace(with kakaoPlaceId: Int) -> AnyPublisher<Bool, Error> {
        PlaceAPI.checkRegisterdPlace(kakaoPlaceId: kakaoPlaceId)
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] isRegisterd in
                self?.outputBool.send(isRegisterd)
            }
            .store(in: &cancelBag)

        return outputBool.eraseToAnyPublisher()
    }
     */
    
    func checkRegisterdPlace(with kakaoPlaceId: Int) -> AnyPublisher<Bool, AddPlaceError> {
        guard let orgId = UserInfoManager.userInfo?.userOrganization else { return Fail(error: AddPlaceError.none).eraseToAnyPublisher() }
        
        return PlaceAPI.checkRegisterdPlace(kakaoPlaceId: kakaoPlaceId, orgId: UserInfoManager.userInfo?.userOrganization[0] ?? 400)
            .mapError { _ -> AddPlaceError in
                return .none
            }.eraseToAnyPublisher()
    }
    
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        CategoryAPI.fetchCategoryList()
            .sink { error in
                switch error {
                case .failure(let error): print(error.localizedString)
                case .finished: break
                }
            } receiveValue: { [weak self] categoryListDTO in
                let categories = categoryListDTO.map {
                    Category(id: $0.id, name: $0.name, imageURL: $0.img)
                }
                self?.outputCategories.send(categories)
            }
            .store(in: &cancelBag)
        
        return outputCategories.eraseToAnyPublisher()
    }

}

enum AddPlaceError: Error {
    case none
}
