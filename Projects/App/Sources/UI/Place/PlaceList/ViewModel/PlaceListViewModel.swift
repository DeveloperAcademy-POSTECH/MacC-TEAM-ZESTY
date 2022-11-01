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
    
    enum PlaceType {
        case whole
        case hot
    }
    
    private let useCase: PlaceListUseCase
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    @Published var placeType: PlaceType = .whole
    
    // Output
    @Published private var wholePage: Int = 1
    @Published private var hotPage: Int = 1
    @Published var result: [Place] = []
    private var wholeResult: [Place] = []
    private var hotResult: [Place] = []
    let isRegisterFail = PassthroughSubject<String, Never>() // alert 용
    
    // MARK: - LifeCycle
    
    init(useCase: PlaceListUseCase = PlaceListUseCase()) {
        self.useCase = useCase
        bind()
    }
    
}

// MARK: - Functions

extension PlaceListViewModel: ErrorMapper {
    
    func prefetch(at rows: [Int]) {
        let unit = 10
        
        switch placeType {
        case .whole:
            for row in rows {
                if (wholePage - 1) * unit <= row && (wholePage * unit) > row {
                    wholePage += 1
                    break
                }
            }
        case .hot:
            for row in rows {
                if (hotPage - 1) * unit <= row && (hotPage * unit) > row {
                    hotPage += 1
                    break
                }
            }
        }

    }
    
    private func bind() {
        $hotPage
            .sink { [weak self] currentPage in
                guard let self = self else { return }
                
                self.useCase.fetchHotPlaceList(with: currentPage)
                    .sink { error in
                        switch error {
                        case .failure(let error):
                            print("🐞: \(error)")
                            let errorMessage = self.errorMessage(for: error)
                            self.isRegisterFail.send(errorMessage)
                        case .finished: break
                        }
                    } receiveValue: { [weak self] placeList in
                        guard let self = self else { return }
                        
                        self.hotResult += placeList
                        self.result = self.hotResult
                    }
                    .store(in: &self.cancelBag)
            }
            .store(in: &cancelBag)
        
        $wholePage
            .sink { [weak self] currentPage in
                guard let self = self else { return }
                
                self.useCase.fetchPlaceList(with: currentPage)
                    .sink { error in
                        switch error {
                        case .failure(let error):
                            let errorMessage = self.errorMessage(for: error)
                            self.isRegisterFail.send(errorMessage)
                        case .finished: break
                        }
                    } receiveValue: { [weak self] placeList in
                        guard let self = self else { return }
                        self.wholeResult += placeList
                        self.result = self.wholeResult
                    }
                    .store(in: &self.cancelBag)
            }
            .store(in: &cancelBag)
        
        $placeType
            .sink { [weak self] type in
                guard let self = self else { return }
                switch type {
                case .whole:
                    self.result = self.wholeResult
                case .hot:
                    self.result = self.hotResult
                }
            }
            .store(in: &self.cancelBag)
    }
    
    // TODO: 맛집 등록하기 버튼 눌렀을 때 뷰컨 반응 구현하기
    func addPlaceButtonTapped() {
//        navigationController?.pushViewController(AddPlaceSearchViewController(viewModel: AddPlaceSearchViewModel()), animated: true)
    }
}
