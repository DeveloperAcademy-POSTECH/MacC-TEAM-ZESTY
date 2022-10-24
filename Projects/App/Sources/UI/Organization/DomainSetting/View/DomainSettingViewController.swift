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
    
    private let viewModel = DomainSettingViewModel()
    
    private let mainTitleView = MainTitleView(title: "학교 이메일을 알려주세요",
                                              subtitle: "학교 인증에 사용돼요.")
    private let emailInputView = UIView()
    private let emailStackView = UIStackView()
    private let emailTextField = UITextField()
    private let emailDuplicatedLabel = UILabel()
    private let domainPlaceholder = UILabel()
    
    // TODO: component로 변경하기
    private let arrowButton = UIButton()
    
    private var keyboardUpConstraints: NSLayoutConstraint?

    private var cancelBag = Set<AnyCancellable>()
    
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
        
        viewModel.$isEmailValid
            .sink {[weak self] isValid in
                // TODO: button disalbed로 변경하기
                guard let self = self else { return }
                self.arrowButton.layer.borderColor = isValid ? UIColor.black.cgColor : UIColor.lightGray.cgColor
                self.arrowButton.tintColor = isValid ? .black : .lightGray
            }
            .store(in: &cancelBag)
        
        viewModel.$isDuplicateEmail
            .sink { [weak self] isDuplicateEmail in
                guard let self = self else { return }
                self.emailDuplicatedLabel.isHidden = !isDuplicateEmail
            }
        
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                if self.keyboardUpConstraints == nil {
                    guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                    let endFrameHeight = endFrame.cgRectValue.height
                    self.keyboardUpConstraints = self.arrowButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -endFrameHeight - 20)
                    self.keyboardUpConstraints?.priority = .defaultLow
                }
                self.keyboardUpConstraints?.isActive = true
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
        emailTextField.keyboardType = .asciiCapable
        
        domainPlaceholder.textColor = .white
        domainPlaceholder.text = "@pos.idserve.net"
        domainPlaceholder.font = .systemFont(ofSize: 17, weight: .medium)
        domainPlaceholder.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        
        emailDuplicatedLabel.textColor = .red
        emailDuplicatedLabel.text = "이미 사용된 이메일이에요."
        emailDuplicatedLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        // TODO: Component로 변경
        arrowButton.tintColor = .lightGray
        arrowButton.backgroundColor = .white
        arrowButton.configuration = .plain()
        arrowButton.configuration?.contentInsets = .init(top: 14.5, leading: 15, bottom: 14.5, trailing: 15)
        arrowButton.clipsToBounds = true
        arrowButton.layer.borderWidth = 2
        arrowButton.layer.cornerRadius = 25
        arrowButton.layer.borderColor = UIColor.lightGray.cgColor

        let arrowImageConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .default)
        let arrowImage = UIImage(systemName: "arrow.forward", withConfiguration: arrowImageConfiguration)
        arrowButton.setImage(arrowImage, for: .normal)
    }
    
    private func createLayout() {
        view.addSubviews([mainTitleView, emailInputView, emailDuplicatedLabel, arrowButton])
        
        emailInputView.addSubview(emailStackView)
        emailStackView.addArrangedSubviews([emailTextField, domainPlaceholder])
        
        mainTitleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        emailInputView.snp.makeConstraints { make in
            make.top.equalTo(mainTitleView.snp.bottom).offset(160)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(310)
        }
        
        emailStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(14)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.width.lessThanOrEqualTo(270)
        }
        
        emailDuplicatedLabel.snp.makeConstraints { make in
            make.top.equalTo(emailInputView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
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
