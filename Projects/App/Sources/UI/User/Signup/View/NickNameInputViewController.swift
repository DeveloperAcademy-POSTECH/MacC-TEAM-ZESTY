//
//  NickNameInputViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import Firebase

enum NicknameInutViewState {
    case signup
    case profile
}

final class NickNameInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private let state: NicknameInutViewState
    
    private let viewModel = NickNameInputViewModel()
    private weak var profileViewModel: ProfileViewModel?
    
    private let mainTitleView = MainTitleView(title: "닉네임을 알려주세요", subtitle: "언제든지 변경할 수 있어요.")
    private let nickNameTextFieldUIView = UIView()
    private let nickNameTextField = UITextFieldPadding(top: 14, left: 20, bottom: 14, right: 20)
    private let nextButton = ArrowButton(initialDisable: true)
    private let warningLabel = UILabel()
    
    private var keyboardEndFrameHeight: CGFloat?
    
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    init(state: NicknameInutViewState, profileViewModel: ProfileViewModel? = nil) {
        self.state = state
        self.profileViewModel = profileViewModel
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
        analytics()
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
    
    private func analytics() {
        FirebaseAnalytics.Analytics.logEvent("nickname_input_viewed", parameters: [
            AnalyticsParameterScreenName: "nickname_input"
        ])
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
                if self.keyboardEndFrameHeight == nil {
                    guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                    self.keyboardEndFrameHeight = endFrame.cgRectValue.height
                }
                self.remakeConstraintsByKeyboard(.show)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancelBag)
        
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .sink { [weak self ] _ in
                guard let self = self else { return }
                self.remakeConstraintsByKeyboard(.hide)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancelBag)
        
        viewModel.$shouldDisplayWarning
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldDisplayWarning in
                guard let self = self else { return }
                self.warningLabel.isHidden = !shouldDisplayWarning
            }
            .store(in: &cancelBag)
        
        viewModel.isNickNameOverlapedSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isNickNameOverlaped in
                guard let self = self else { return }
                self.nextButton.stopIndicator()
                if isNickNameOverlaped {
                    self.nextButton.setDisabled(true)
                }
            }
            .store(in: &cancelBag)
        
        viewModel.isNickNameChangedSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isNickNameChanged in
                guard let self = self else { return }
                if isNickNameChanged {
                    switch self.state {
                    case .signup:
                        self.navigationController?.pushViewController(SignupCompleteViewController(), animated: true)
                    case .profile:
                        self.profileViewModel?.isNickNameChangedSubject.send(true)
                        self.navigationController?.popViewController(animated: true)
                    }
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
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    
        nickNameTextField.becomeFirstResponder()
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
        view.addSubviews([mainTitleView, nickNameTextFieldUIView, nextButton, warningLabel])
        nickNameTextFieldUIView.addSubview(nickNameTextField)
        
        mainTitleView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        nickNameTextFieldUIView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainTitleView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(nickNameTextFieldUIView.snp.centerX)
            make.centerY.equalTo(nickNameTextFieldUIView.snp.centerY)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.bottom.equalTo(view.snp.bottom).offset(-100)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(14)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func remakeConstraintsByKeyboard(_ state: KeyboardState) {
        guard let keyboardEndFrameHeight = self.keyboardEndFrameHeight else { return }
        switch state {
        case .show:
            nextButton.snp.remakeConstraints { make in
                make.trailing.equalTo(view.snp.trailing).offset(-20)
                make.bottom.equalTo(view.snp.bottom).offset(-keyboardEndFrameHeight-20)
            }
            self.nickNameTextFieldUIView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(mainTitleView.snp.top)
                make.bottom.equalTo(view.snp.bottom).offset(-keyboardEndFrameHeight)
            }
        case .hide:
            nextButton.snp.remakeConstraints { make in
                make.trailing.equalTo(view.snp.trailing).offset(-20)
                make.bottom.equalTo(view.snp.bottom).offset(-100)
            }
            self.nickNameTextFieldUIView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(mainTitleView.snp.top)
                make.bottom.equalTo(view.snp.bottom)
            }
        }
    }
    
}

extension NickNameInputViewController {
    private enum KeyboardState {
        case show
        case hide
    }
}

#if DEBUG
import SwiftUI
struct NickNameInputViewTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        NickNameInputViewController(state: .profile).toPreview()
    }

}
#endif
