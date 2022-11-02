//
//  OTPStackView.swift
//  App
//
//  Created by 김태호 on 2022/11/02.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit
import DesignSystem

protocol OTPDelegate: AnyObject {
    func didChangeValidity(isValid: Bool)
}

final class OTPStackView: UIStackView {
    
    // MARK: - Properties
    
    weak var delegate: OTPDelegate?
    
    private let numberOfFields: Int = 4
    private lazy var textFieldArray: [OTPTextField] = []
    private var showWarningMessage: Bool = false
    
    private let textBackgroundColor = UIColor.zestyColor(.grayF6)
    private var remainingStrStack: [String] = []
    private var userTextInput: String = ""
    
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
    
    private func checkForValidity() {
        for fields in textFieldArray where fields.text == "" {
            delegate?.didChangeValidity(isValid: false)
            return
        }
        delegate?.didChangeValidity(isValid: true)
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
        checkForValidity()
    }
    
}

extension OTPStackView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if showWarningMessage {
            showWarningMessage = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            autoFillTextField(with: string)
            return false
        } else {
            if range.length == 0 {
                if textField.nextTextField == nil {
                    textField.text? = string
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                textField.backgroundColor = .black
                return false
            }
            textField.backgroundColor = .zestyColor(.grayF6)
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
