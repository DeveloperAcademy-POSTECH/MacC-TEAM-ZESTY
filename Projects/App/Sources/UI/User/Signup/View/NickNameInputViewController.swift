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

final class NickNameInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = NickNameInputViewModel()
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nickNameTextField = UITextFieldPadding(top: 14, left: 20, bottom: 14, right: 20)
    private let nextButtonView = ShadowButtonView(initialDisable: true)
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
        nextButtonView.startAnimating()
        nextButtonView.button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
        nextButtonView.button.imageView?.isHidden = true
        
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
        
        nickNameTextField.textDidBeignEditingPublisher
            .map { _ in return true }
            .assign(to: \.isKeyboardShown, on: viewModel)
            .store(in: &cancelBag)
        
        nickNameTextField.textDidEndEditingPublisher
            .map { _ in return false }
            .assign(to: \.isKeyboardShown, on: viewModel)
            .store(in: &cancelBag)
        
        viewModel.$isTextEmpty
            .sink { [weak self] isTextEmpty in
                self?.nextButtonView.setDisabled(isTextEmpty)
            }
            .store(in: &cancelBag)
        
        viewModel.$isKeyboardShown
            .sink { [weak self] isKeyboardShown in
                guard let self = self else { return }
                self.keyboardUpConstraints?.isActive = isKeyboardShown
                self.keyboardDownConstraints?.isActive = !isKeyboardShown
            }
            .store(in: &cancelBag)
        
        viewModel.$isUserReceivedWarning
            .sink { [weak self] isUserReceivedWarning in
                guard let self = self else { return }
                self.warningLabel.isHidden = !isUserReceivedWarning
            }
            .store(in: &cancelBag)
        
        viewModel.isNickNameOverlapedSubject
            .sink { [weak self] isNickNameOverlaped in
                guard let self = self else { return }
                self.nextButtonView.stopAnimating()
                self.nextButtonView.button.setAttributedTitle(NSAttributedString(string: "다음",
                                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]), for: .normal)
                self.nextButtonView.button.imageView?.isHidden = false
                if isNickNameOverlaped {
                    self.nextButtonView.setDisabled(true)
                } else {
                    self.navigationController?.pushViewController(SignupCompleteViewController(), animated: true)
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
        if nextButtonView.button.isUserInteractionEnabled {
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
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 12
        
        titleLabel.text = "멋진 이름을 알려주세요"
        titleLabel.font = .systemFont(ofSize: 26)
        
        subtitleLabel.text = "언제든지 변경할 수 있어요."
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .preferredFont(forTextStyle: .callout)
        
        nickNameTextField.attributedPlaceholder = .init(attributedString: NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]))
        nickNameTextField.font = .preferredFont(forTextStyle: .body)
        nickNameTextField.textColor = .white
        nickNameTextField.backgroundColor = .black
        nickNameTextField.clipsToBounds = true
        nickNameTextField.layer.cornerRadius = 25
        
        let arrowImageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular, scale: .default)
        let arrowImage = UIImage(systemName: "arrow.forward", withConfiguration: arrowImageConfiguration)
        nextButtonView.button.setAttributedTitle(NSAttributedString(string: "다음",
                                                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]), for: .normal)
        nextButtonView.button.setImage(arrowImage, for: .normal)
        nextButtonView.button.semanticContentAttribute = .forceRightToLeft
        nextButtonView.button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        warningLabel.text = "이미 있는 이름이에요"
        warningLabel.textColor = .red
        warningLabel.font = .preferredFont(forTextStyle: .footnote)
        warningLabel.isHidden = true
    }
    
    private func createLayout() {
        view.addSubviews([titleStackView, nickNameTextField, nextButtonView, warningLabel])
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])
        
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        nextButtonView.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(14)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        keyboardUpConstraints = nextButtonView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20)
        keyboardDownConstraints = nextButtonView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor, constant: -100)
        keyboardUpConstraints?.priority = .defaultLow
        keyboardDownConstraints?.priority = .defaultLow
        keyboardDownConstraints?.isActive = true
    }
    
}
