//
//  NickNameInputViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import DesignSystem

final class NickNameInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = NickNameInputViewModel()
    
    private let mainTitleView = MainTitleView(title: "닉네임을 알려주세요", subtitle: "언제든지 변경할 수 있어요.")
    private let nickNameTextField = UITextFieldPadding(top: 14, left: 20, bottom: 14, right: 20)
    private let nextButton = ArrowButton(initialDisable: true)
    private let warningLabel = UILabel()
    
    private var keyboardUpConstraints: NSLayoutConstraint?
    private var keyboardDownConstraints: NSLayoutConstraint?
    
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bindUI()
        nickNameTextField.delegate = self
    }
    
    // MARK: - Function
    
    @objc private func nextButtonClicked() {
        nextButton.startIndicator()
        
        viewModel.checkNickNameOverlaped()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nickNameTextField.resignFirstResponder()
    }
    
}

// MARK: - Bind Function

extension NickNameInputViewController {
    
    private func bindUI() {
        nickNameTextField.textDidChangePublisher
            .compactMap { $0.text }
            .assign(to: \.nickNameText, on: viewModel)
            .store(in: &cancelBag)
        
        viewModel.$isTextEmpty
            .sink { [weak self] isTextEmpty in
                self?.nextButton.setDisabled(isTextEmpty)
            }
            .store(in: &cancelBag)
        
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                if self.keyboardUpConstraints == nil {
                    guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                    let endFrameHeight = endFrame.cgRectValue.height
                    self.keyboardUpConstraints = self.nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -endFrameHeight - 20)
                    self.keyboardUpConstraints?.priority = .defaultLow
                }
                self.keyboardDownConstraints?.isActive = false
                self.keyboardUpConstraints?.isActive = true
            }
            .store(in: &cancelBag)
        
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .sink { [weak self ] _ in
                guard let self = self else { return }
                self.keyboardUpConstraints?.isActive = false
                self.keyboardDownConstraints?.isActive = true
            }
            .store(in: &cancelBag)
        
        viewModel.$shouldDisplayWarning
            .sink { [weak self] shouldDisplayWarning in
                guard let self = self else { return }
                self.warningLabel.isHidden = !shouldDisplayWarning
            }
            .store(in: &cancelBag)
        
        viewModel.isNickNameOverlapedSubject
            .sink { [weak self] isNickNameOverlaped in
                guard let self = self else { return }
                self.nextButton.stopIndicator()
                if isNickNameOverlaped {
                    self.nextButton.setDisabled(true)
                } else {
                    self.navigationController?.pushViewController(SignupCompleteViewController(), animated: true)
                }
            }
            .store(in: &cancelBag)
        
        nickNameTextField.textDidChangePublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0.text }
            .sink { text in
                if text.count > self.viewModel.maxNickNameLength {
                    self.nickNameTextField.text?.removeLast()
                }
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - Delegate Function

extension NickNameInputViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModel.isValid(for: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if nextButton.isUserInteractionEnabled {
            nextButtonClicked()
        }
        return true
    }
    
}

// MARK: - UI Function

extension NickNameInputViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    
        nickNameTextField.attributedPlaceholder = .init(attributedString: NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]))
        nickNameTextField.font = .preferredFont(forTextStyle: .body)
        nickNameTextField.textColor = .white
        nickNameTextField.backgroundColor = .black
        nickNameTextField.clipsToBounds = true
        nickNameTextField.layer.cornerRadius = 25
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        warningLabel.text = "이미 있는 이름이에요"
        warningLabel.textColor = .red
        warningLabel.font = .preferredFont(forTextStyle: .footnote)
        warningLabel.isHidden = true
    }
    
    private func createLayout() {
        view.addSubviews([mainTitleView, nickNameTextField, nextButton, warningLabel])
        
        mainTitleView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(14)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        keyboardDownConstraints = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        keyboardDownConstraints?.isActive = true
        keyboardDownConstraints?.priority = .defaultHigh
    }
    
}

struct NickNameInputViewTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        NickNameInputViewController().toPreview()
    }

}
