//
//  AddPlaceResultViewModel.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import Network

class AddPlaceResultViewModel {
    
    enum Input {
        case viewDidLoad
    }
    
    enum Output {
        case loadPlaceResultSucceed(place: PlaceResult)
    }
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let output: PassthroughSubject<Output, Never> = .init()
 
    private var place: PlaceResult
    
    init(place: PlaceResult) {
        self.place = place
    }
    
    // MARK: - transform : Input -> Output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.output.send(.loadPlaceResultSucceed(place: self!.place))
            }
        }.store(in: &cancelBag)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - functions
 
}
