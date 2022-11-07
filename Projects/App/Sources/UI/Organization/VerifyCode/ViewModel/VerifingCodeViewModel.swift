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
    
    let userEmail = "mingming@pos.idserve.net"
    var isArrowButtonHidden: Bool = true
    var isCodeValid: Bool = true
    var userInputCode: String = ""
    var timer = "03:00"
    
}
