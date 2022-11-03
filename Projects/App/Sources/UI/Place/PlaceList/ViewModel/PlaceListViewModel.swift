//
//  PlaceListViewModel.swift
//  App
//
//  Created by 리아 on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation
import Network

class PlaceListViewModel {
    
    // MARK: - Properties

    private let useCase: PlaceListUseCase
    private var cancelBag = Set<AnyCancellable>()
    
    class Section {
        let type: PlaceType
        var lastIndex: Int = -1
        var cursor: Int = 1
        var placeList: [Place] = []
        
        init(type: PlaceType) {
            self.type = type
        }
    }
    
    // Input
    @Published var placeType: PlaceType = .whole
    
    // Output
    @Published var result: [Place] = []
    private var wholePlace = Section(type: .whole)
    private var hotPlace = Section(type: .hot)
    let isRegisterFail = PassthroughSubject<String, Never>() // alert 용
    
    // MARK: - LifeCycle
    
    init(useCase: PlaceListUseCase = PlaceListUseCase()) {
        self.useCase = useCase
        prefetch(at: [1])
        bind()
    }
    
}

// MARK: - Functions

extension PlaceListViewModel: ErrorMapper {
    
    func prefetch(at rows: [Int]) {
        let section: Section
        
        switch placeType {
        case .whole:
            section = wholePlace
        case .hot:
            section = hotPlace
        }
        
        // fetch 여부는 해당 row가 이미 불려진 row인지로 판단
        for row in rows where row >= section.lastIndex {
            useCase.fetchPlaceList(with: section.cursor,
                                   type: section.type)
                .sink { [weak self] error in
                    guard let self = self else { return }
                    
                    switch error {
                    case .failure(let error):
                        let errorMessage = self.errorMessage(for: error)
                        self.isRegisterFail.send(errorMessage)
                    case .finished: break
                    }
                } receiveValue: { [weak self] placeList in
                    guard let self = self, !placeList.isEmpty else { return }
                    
                    // fetch된 데이터 업데이트
                    section.placeList += placeList
                    section.lastIndex += placeList.count
                    // 서버에 요청할 인덱스 = 가장 마지막 데이터의 placeID + 1
                    section.cursor = section.placeList[section.lastIndex].id + 1
                    self.result = section.placeList
                }
                .store(in: &self.cancelBag)
            break
        }
    }
    
    private func bind() {
        $placeType
            .sink { [weak self] type in
                guard let self = self else { return }
                switch type {
                case .whole:
                    self.result = self.wholePlace.placeList
                case .hot:
                    self.result = self.hotPlace.placeList
                }
            }
            .store(in: &self.cancelBag)
    }

}
