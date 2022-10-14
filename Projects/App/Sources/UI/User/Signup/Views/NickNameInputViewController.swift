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
    
    // MARK: Properties
    
    private let viewModel = NickNameInputViewModel()
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nickNameTextField = UITextFieldPadding(top: 14, left: 20, bottom: 14, right: 20)
    private let nextButtonView = ShadowButtonView(initialDisable: true)
    
    private var keyboardUpConstraints: NSLayoutConstraint?
    private var keyboardDownConstraints: NSLayoutConstraint?
    
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var nickNameTextFieldPublisher: AnyPublisher<String, Never> = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: nickNameTextField)
        .compactMap { $0.object as? UITextField }
        .compactMap { $0.text }
        .eraseToAnyPublisher()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        bindUI()
        nickNameTextField.delegate = self
    }
    
    // MARK: Function
    
    @objc private func nextButtonClicked() {
        navigationController?.pushViewController(SignupCompleteViewController(), animated: true)
    }
    
    private func bindUI() {
        nickNameTextFieldPublisher
            .assign(to: \.nickNameText, on: viewModel)
            .store(in: &cancelBag)
        
        viewModel.$isTextEmpty
            .sink { [weak self] isTextEmpty in
                self?.nextButtonView.setDisable(isTextEmpty)
            }
            .store(in: &cancelBag)
        
        viewModel.$isKeyboardShown
            .sink { [weak self] isKeyboardShown in
                guard let self = self else { return }
                self.keyboardUpConstraints?.isActive = isKeyboardShown
                self.keyboardDownConstraints?.isActive = !isKeyboardShown
            }
            .store(in: &cancelBag)
    }
    
    private func checkValidCharacter(to string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\\s]$", options: .caseInsensitive)
            if regex.firstMatch(in: string, options: NSRegularExpression.MatchingOptions.reportCompletion, range: .init(location: 0, length: string.count)) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let activatedField = viewModel.activatedField {
                activatedField.resignFirstResponder()
        }
    }

}

extension NickNameInputViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxNickNameCount = 6
        let isBackSpace = strcmp(string.cString(using: .utf8), "\\b") == -92
        if (viewModel.nickNameText.count < maxNickNameCount && checkValidCharacter(to: string)) || isBackSpace {
            return true
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel.activatedField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.activatedField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension NickNameInputViewController {
    
    // MARK: UI Function
    
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
    }
    
    private func configureLayout() {
        view.addSubview(titleStackView)
        view.addSubview(nickNameTextField)
        view.addSubview(nextButtonView)
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
        
        keyboardUpConstraints = nextButtonView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20)
        keyboardDownConstraints = nextButtonView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor, constant: -100)
        keyboardUpConstraints?.priority = .defaultLow
        keyboardDownConstraints?.priority = .defaultLow
        keyboardDownConstraints?.isActive = true
    }
    
}
