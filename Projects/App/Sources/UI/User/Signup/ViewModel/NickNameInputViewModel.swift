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
    @Published var shouldDisplayWarning = false
    let isNickNameOverlapedSubject = PassthroughSubject<Bool, Never>()
    
    // Input & Output
    @Published var isKeyboardShown = false

    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $nickNameText
            .map(isEmpty)
            .assign(to: \.isTextEmpty, on: self)
            .store(in: &cancelBag)
        
        $nickNameText
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.shouldDisplayWarning {
                    self.shouldDisplayWarning = false
                }
            }
            .store(in: &cancelBag)
    }
    
    private func isEmpty(to text: String) -> Bool {
        return text.isEmpty
    }
    
    func checkNickNameOverlaped() {
        // TODO: UseCase와 통신하여 중복 체크
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let result = Bool.random()
            self.isNickNameOverlapedSubject.send(result)
            if result {
                self.shouldDisplayWarning = true
            }
        }
    }
    
    func isValid(for input: String) -> Bool {
        let maxNickNameCount = 6
        let isBackSpace = strcmp(input.cString(using: .utf8), "\\b") == -92
        if (nickNameText.count < maxNickNameCount && checkValidCharacter(to: input)) || isBackSpace {
            return true
        }
        return false
    }

    private func checkValidCharacter(to string: String) -> Bool {
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
