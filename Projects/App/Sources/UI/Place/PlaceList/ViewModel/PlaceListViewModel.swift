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
    
    // Input
    @Published var page: Int = 1
    
    // Output
    @Published var result: [Place] = []
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
        for row in rows {
            if (page - 1) * unit <= row && (page * unit) > row {
                page += 1
                break
            }
        }
    }
    
    private func bind() {
        $page
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
                    } receiveValue: { placeList in
                        self.result += placeList
                    }
                    .store(in: &self.cancelBag)
            }
            .store(in: &cancelBag)
    }
        
}
