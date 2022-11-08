//
//  OTPStackView.swift
//  App
//
//  Created by 김태호 on 2022/11/02.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem

/// 출처 : https://github.com/satyen95/iOS-OTPField/blob/master/OTPField/OTPField/OTPStackView.swift

final class OTPStackView: UIStackView {
    
    // MARK: - Properties
    private let numberOfFields: Int = 4
    private lazy var textFieldArray: [OTPTextField] = []
    private var showWarningMessage: Bool = false
    
    private let textBackgroundColor = UIColor.zestyColor(.grayF6)
    private var remainingStrStack: [String] = []
    
    // output
    let otpText = PassthroughSubject<String, Never>()
    
    // MARK: - LifeCycle
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addOTPFields()
    }
    
    // MARK: - Function
    
    func resetOTP() {
        for textField in textFieldArray {
            textField.text = ""
            textField.backgroundColor = textBackgroundColor
        }
        textFieldArray[0].becomeFirstResponder()
    }
    
    func getOTP() -> String {
        var OTP: String = ""
        for textField in textFieldArray {
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    func sendOTP() {
        let OTP = getOTP()
        otpText.send(OTP)
    }
    
}
  
// MARK: - UI Function

extension OTPStackView {
    
    private final func setupStackView() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        contentMode = .center
        distribution = .fillEqually
        spacing = 10
    }
    
    private func setupTextField(_ textField: OTPTextField) {
        addArrangedSubview(textField)
        
        textField.delegate = self
        textField.backgroundColor = textBackgroundColor
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 17, weight: .bold)
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.keyboardType = .numberPad
        textField.tintColor = .clear
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(40)
        }
        
    }
    
    private func addOTPFields() {
        for index in 0..<numberOfFields {
            let field = OTPTextField()
            setupTextField(field)
            textFieldArray.append(field)
            
            index != 0 ? (field.previousTextField = textFieldArray[index-1]) : (field.previousTextField = nil)
            index != 0 ? (textFieldArray[index-1].nextTextField = field) : ()
        }
        textFieldArray[0].becomeFirstResponder()
    }
    
    private func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap { String($0) }
        for textField in textFieldArray {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
                textField.backgroundColor = .black
            } else {
                break
            }
        }
    }
    
}

extension OTPStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if showWarningMessage {
            showWarningMessage = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            autoFillTextField(with: string)
            sendOTP()
            return false
        } else {
            if range.length == 0 && string == "" {
                sendOTP()
                return false
            } else if range.length == 0 {
                if textField.nextTextField == nil {
                    textField.text? = string
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                textField.backgroundColor = .black
                sendOTP()
                return false
            }
            return true
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct OTPStackViewPreview: PreviewProvider {
    
    static var previews: some View {
        OTPStackView().toPreview()
    }
    
}
#endif
