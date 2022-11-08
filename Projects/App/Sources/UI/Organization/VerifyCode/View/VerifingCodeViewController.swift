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
    private var cancelBag = Set<AnyCancellable>()
    
    private let isSE: Bool = UIScreen.main.isHeightLessThan670pt
    private var keyboardEndFrameHeight: CGFloat?
    
    private let viewModel: VerifingCodeViewModel
    
    private lazy var titleView = MainTitleView(title: "이메일로 받은 코드를\n알려주세요",
                                               subtitle: "\(viewModel.userEmail)",
                                               hasSymbol: true)
    
    private let warningMessage = UILabel()
    private let otpStackView = OTPStackView()
    private let timerLabel = UILabel()
    
    private let resendStackView = UIStackView()
    private let resendLabel = UILabel()
    private let resendEamilButton = UIButton(type: .custom)
    
    private let arrowButton = ArrowButton(initialDisable: false)
    
    // MARK: - LifeCycle
    
    init(organization: Organization, userEmail: String) {
        self.viewModel = VerifingCodeViewModel(organization: organization, userEmail: userEmail)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bindUI()
        viewModel.startTimer()
    }
    
    // MARK: - Function
    
    @objc func resendButtonTapped() {
        showToastMessage()
        viewModel.shouldDisplayWarning = false
        viewModel.resendEamil()
        viewModel.startTimer()
    }
    
    private func showToastMessage() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        toastLabel.textAlignment = .center
        toastLabel.text = "메일을 다시 보냈어요"
        toastLabel.layer.cornerRadius = 25
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        toastLabel.layer.zPosition = 999
        
        self.navigationController?.view.addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.top)
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

// MARK: Bind Function

extension VerifingCodeViewController {
    
    private func bindUI() {
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                if self.keyboardEndFrameHeight == nil {
                    guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                    self.keyboardEndFrameHeight = endFrame.cgRectValue.height
                }
                self.remakeConstraintsByKeyboard(.show)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancelBag)
        
        viewModel.$timerText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] timerText in
                guard let self = self else { return }
                self.timerLabel.text = timerText
                self.timerLabel.textColor = timerText.count > 5 ? .zestyColor(.point) : .label
            }
            .store(in: &cancelBag)
        
        viewModel.isCodeValidSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isCodeValid in
                guard let self = self else { return }
                self.arrowButton.isHidden = true
                if isCodeValid {
                    print("유효한 코드입니다")
                } else {
                    self.otpStackView.resetOTP()
                }
            }
            .store(in: &cancelBag)
        
        viewModel.$shouldDisplayWarning
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldDisplayWarning in
                guard let self = self else { return }
                self.warningMessage.isHidden = !shouldDisplayWarning
            }
            .store(in: &cancelBag)
        
        otpStackView.otpText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] otpText in
                guard let self = self else { return }
                
                if self.viewModel.shouldDisplayWarning {
                    self.viewModel.shouldDisplayWarning = false
                }
                if otpText.count == 4 {
                    self.arrowButton.isHidden = false
                    self.viewModel.postOTPCode(code: otpText)
                }
            }
            .store(in: &cancelBag)
        
    }
    
}

// MARK: - UI Function

extension VerifingCodeViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = ""
        
        warningMessage.text = "잘못된 코드예요."
        warningMessage.isHidden = !viewModel.shouldDisplayWarning
        warningMessage.textColor = .zestyColor(.point)
        
        timerLabel.text = viewModel.timerText
        
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
        
        arrowButton.isHidden = true
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
            make.top.equalTo(titleView.snp.bottom).offset(isSE ? 20 : 82)
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
            make.bottom.equalTo(view.snp.bottom).offset(-20)
        }
    }
    
    private func remakeConstraintsByKeyboard(_ state: KeyboardState) {
        guard let keyboardEndFrameHeight = self.keyboardEndFrameHeight else { return }
        switch state {
        case .hide:
            arrowButton.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(20)
                make.bottom.equalTo(view.snp.bottom).offset(-20)
            }
        case .show:
            arrowButton.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(20)
                make.bottom.equalTo(view.snp.bottom).offset(-keyboardEndFrameHeight-20)
            }
        }
    }
}

extension VerifingCodeViewController {
    private enum KeyboardState {
        case show
        case hide
    }
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct VerifingCodePreview: PreviewProvider {
    
    static var previews: some View {
        VerifingCodeViewController(organization: Organization.mockData[0], userEmail: "mingming@gmail.com").toPreview()
    }
    
}
#endif
