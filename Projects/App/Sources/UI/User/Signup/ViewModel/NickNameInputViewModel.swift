//
//  NickNameInputViewModel.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import Foundation

final class NickNameInputViewModel {
    
    // Input
    @Published var nickNameText = ""
    
    // Output
    @Published var isTextEmpty = true
    
    // Input & Output
    @Published var isKeyboardShown = false

    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $nickNameText
            .map(isEmpty)
            .assign(to: \.isTextEmpty, on: self)
            .store(in: &cancelBag)
    }
    
    private func isEmpty(to text: String) -> Bool {
        return text.isEmpty
    }
    
    func checkValidCharacter(to string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\\s]$", options: .caseInsensitive)
            if regex.firstMatch(in: string, options: NSRegularExpression.MatchingOptions.reportCompletion, range: .init(location: 0, length: string.count)) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
}
