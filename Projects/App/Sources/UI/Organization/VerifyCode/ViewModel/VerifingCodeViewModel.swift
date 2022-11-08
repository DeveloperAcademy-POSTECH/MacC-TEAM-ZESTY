//
//  VerifingCodeViewModel.swift
//  App
//
//  Created by 김태호 on 2022/11/07.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import Foundation

final class VerifingCodeViewModel {
    
    // MARK: - Properties
    let organization: Organization
    let userEmail: String
    
    private var timer: Timer?
    private var timerNumber: Int = 180
    private let oneMinuteToSecond: Int = 60
    
    var isArrowButtonHidden: Bool = true
    
    // input
    @Published var userInputCode: String = ""
    
    // output
    @Published var timerText = "03:00"
    @Published var shouldDisplayWarning: Bool = true
    
    // MARK: - LifeCycle
    
    init(organization: Organization, userEmail: String) {
        self.organization = organization
        self.userEmail = userEmail
    }
    
}

// MARK: - Bind Fucntions

extension VerifingCodeViewModel {
    
    private func bind() {
        
    }
    
}

// MARK: - Functions

extension VerifingCodeViewModel {
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkTimeAfter1Second), userInfo: nil, repeats: true)
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timerText = "03:00"
        timerNumber = 180
    }
    
    @objc private func checkTimeAfter1Second() {
        if timerNumber > 0 {
            timerNumber -= 1
            let minutes = timerNumber/oneMinuteToSecond
            let seconds = timerNumber % oneMinuteToSecond
            timerText = String(format: "%02d:%02d", minutes, seconds)
        } else {
            timerNumber = 0
            timerText = "인증시간 초과"
            timer?.invalidate()
        }
    }
    
}
