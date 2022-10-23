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
    
    private let useCase = UserSignupUseCase()
    
    // Input
    @Published var nickNameText = ""
    
    // Output
    @Published var isTextEmpty = true
    @Published var shouldDisplayWarning = false
    let isNickNameOverlapedSubject = PassthroughSubject<Bool, Never>()
    let isNickNameChangedSubject = PassthroughSubject<Bool, Never>()

    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $nickNameText
            .map(isEmpty)
            .assign(to: \.isTextEmpty, on: self)
            .store(in: &cancelBag)
        
        $nickNameText
            .sink { [weak self] _ in
                if let self = self, self.shouldDisplayWarning {
                    self.shouldDisplayWarning = false
                }
            }
            .store(in: &cancelBag)
        
        useCase.isNickNameOverlapedSubject
            .sink { [weak self] isNickNameOverlaped in
                guard let self = self else { return }
                self.isNickNameOverlapedSubject.send(isNickNameOverlaped)
                if isNickNameOverlaped {
                    self.shouldDisplayWarning = true
                } else {
                    self.useCase.putNicknameUser(nickname: self.nickNameText)
                }
            }
            .store(in: &cancelBag)
        
        useCase.isNickNameChangedSubject
            .sink { [weak self] isNickNameChanged in
                guard let self = self else { return }
                self.isNickNameChangedSubject.send(isNickNameChanged)
            }
            .store(in: &cancelBag)
        
    }
    
    private func isEmpty(to text: String) -> Bool {
        return text.isEmpty
    }
    
    func checkNickNameOverlaped() {
        useCase.getNicknameValidationUser(nickname: nickNameText)
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
