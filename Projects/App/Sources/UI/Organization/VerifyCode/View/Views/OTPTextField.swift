//
//  OTPTextField.swift
//  App
//
//  Created by 김태호 on 2022/11/02.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit

final class OTPTextField: UITextField {
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override public func deleteBackward() {
        if let text = text, text.isEmpty {
            previousTextField?.text = ""
            previousTextField?.backgroundColor = .codeInputEmpty
            previousTextField?.previousTextField?.becomeFirstResponder()
        }
        
        text = ""
        backgroundColor = .codeInputEmpty
        previousTextField?.becomeFirstResponder()
    }
}
