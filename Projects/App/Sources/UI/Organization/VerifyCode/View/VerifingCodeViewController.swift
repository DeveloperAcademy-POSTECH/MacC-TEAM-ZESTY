//
//  VerifingCodeViewController.swift
//  App
//
//  Created by 김태호 on 2022/11/02.
//  Copyright (c) 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class VerifingCodeViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private lazy var titleView = MainTitleView(title: "이메일로 받은 코드를\n알려주세요", subtitle: "\(userEmail)", hasSymbol: true)
    
    private let warningMessage = UILabel()
    private let otpStackView = OTPStackView()
    private let timerLabel = UILabel()
    
    private let resendStackView = UIStackView()
    private let resendLabel = UILabel()
    private let resendEamilButton = UIButton(type: .custom)
    
    private let arrowButton = ArrowButton(initialDisable: true)
    
    // TODO: ViewModel로 옮길 것들입니다
    let userEmail = "mingming@pos.idserve.net"
    var isArrowButtonHidden: Bool = true
    var isCodeValid: Bool = true
    var userInputCode: String = ""
    var timer = "03:00"
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc func resendButtonTapped() {
        print("버튼 눌림")
        showToastMessage()
    }
    
    private func showToastMessage() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        toastLabel.textAlignment = .center
        toastLabel.text = "메일을  다시 보냈어요"
        toastLabel.layer.cornerRadius = 25
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        self.view.addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(-50)
            make.width.equalTo(173)
            make.height.equalTo(50)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            toastLabel.center.y = 100
        })
        
        UIView.animate(withDuration: 0.3, delay: 2.5, options: .curveEaseIn, animations: {
            toastLabel.center.y = 0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
}

// MARK: - UI Function

extension VerifingCodeViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        warningMessage.text = "잘못된 코드예요."
        warningMessage.isHidden = isCodeValid
        
        timerLabel.text = timer
        
        resendStackView.spacing = 10
        resendStackView.axis = .horizontal
        resendStackView.distribution = .fill
        resendStackView.alignment = .fill
        
        resendLabel.text = "메일이 오지 않았나요?"
        resendLabel.font = .systemFont(ofSize: 13, weight: .regular)
        resendLabel.numberOfLines = 0
        
        resendEamilButton.setTitle("다시 보내기", for: .normal)
        resendEamilButton.setTitleColor(.label, for: .normal)
        resendEamilButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        resendEamilButton.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
        arrowButton.isHidden = isArrowButtonHidden
        arrowButton.startIndicator()
    }
    
    private func createLayout() {
        view.addSubviews([titleView, warningMessage, otpStackView, timerLabel, resendStackView, arrowButton])
        resendStackView.addArrangedSubviews([resendLabel, resendEamilButton])
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
        }
        
        warningMessage.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(82)
            make.centerX.equalToSuperview()
        }
        
        otpStackView.snp.makeConstraints { make in
            make.top.equalTo(warningMessage.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(190)
            make.centerX.equalToSuperview()
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(otpStackView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        resendStackView.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct VerifingCodePreview: PreviewProvider {
    
    static var previews: some View {
        VerifingCodeViewController().toPreview()
    }
    
}
#endif
