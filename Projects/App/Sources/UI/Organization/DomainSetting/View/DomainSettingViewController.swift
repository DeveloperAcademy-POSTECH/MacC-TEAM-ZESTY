//
//  DomainSettingViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class DomainSettingViewController: UIViewController {

    // MARK: - Properties
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let viewModel = DomainSettingViewModel()
    
    private let mainTitleView = MainTitleView(title: "학교 이메일을 알려주세요",
                                              subtitle: "학교 인증에 사용돼요.")
    private let keyboardSafeArea = UIView()
    private let emailInputView = UIView()
    private let emailStackView = UIStackView()
    private let emailTextField = UITextField()
    private let emailDuplicatedLabel = UILabel()
    private let domainPlaceholder = UILabel()
    private let arrowButton = ArrowButton(initialDisable: true)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - Bind Function

extension DomainSettingViewController {
    
    private func bindUI() {
        emailTextField.textDidChangePublisher
            .compactMap { $0.text }
            .assign(to: \.userEmail, on: viewModel)
            .store(in: &cancelBag)
        
        viewModel.$isEmailEmpty
            .sink {[weak self] isEmailEmpty in
                self?.arrowButton.setDisabled(isEmailEmpty)
            }
            .store(in: &cancelBag)
        
        viewModel.$isDuplicateEmail
            .sink { [weak self] isDuplicateEmail in
                guard let self = self else { return }
                self.emailDuplicatedLabel.isHidden = !isDuplicateEmail
            }
            .store(in: &cancelBag)
        
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                let endFrameHeight = endFrame.cgRectValue.height
                
                self.remakeConstraintsByKeyboard(keyboardHeight: endFrameHeight)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function

extension DomainSettingViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        emailInputView.backgroundColor = .black
        emailInputView.layer.cornerRadius = 25
        emailInputView.layer.masksToBounds = true
        
        emailStackView.spacing = 10
        emailStackView.axis = .horizontal
        emailStackView.distribution = .fill
        emailStackView.alignment = .fill

        emailTextField.becomeFirstResponder()
        emailTextField.attributedPlaceholder = .init(attributedString: NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        emailTextField.textColor = .white
        emailTextField.font = .systemFont(ofSize: 17, weight: .medium)
        emailTextField.keyboardType = .emailAddress
        
        domainPlaceholder.textColor = .white
        domainPlaceholder.text = "@pos.idserve.net"
        domainPlaceholder.font = .systemFont(ofSize: 17, weight: .medium)
        domainPlaceholder.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        
        emailDuplicatedLabel.textColor = .red
        emailDuplicatedLabel.text = "이미 사용된 이메일이에요."
        emailDuplicatedLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        let arrowImageConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .default)
        let arrowImage = UIImage(systemName: "arrow.forward", withConfiguration: arrowImageConfiguration)
        arrowButton.setImage(arrowImage, for: .normal)
    }
    
    private func createLayout() {
        view.addSubviews([mainTitleView, keyboardSafeArea])
        
        keyboardSafeArea.addSubviews([emailInputView, emailDuplicatedLabel, arrowButton])
        
        emailInputView.addSubview(emailStackView)
        emailStackView.addArrangedSubviews([emailTextField, domainPlaceholder])
        
        mainTitleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        remakeConstraintsByKeyboard()
        
        emailInputView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(310)
        }
        
        emailStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(270)
        }
        
        emailDuplicatedLabel.snp.makeConstraints { make in
            make.top.equalTo(emailInputView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func remakeConstraintsByKeyboard(keyboardHeight: CGFloat? = nil) {
        guard let keyboardHeight = keyboardHeight else {
            keyboardSafeArea.snp.makeConstraints { make in
                make.top.equalTo(mainTitleView.snp.bottom)
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            return
        }
        
        keyboardSafeArea.snp.makeConstraints { make in
            make.top.equalTo(mainTitleView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(keyboardHeight)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct DomainSettingViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        DomainSettingViewController().toPreview()
    }
    
}
#endif
