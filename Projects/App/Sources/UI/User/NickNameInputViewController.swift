//
//  NickNameInputViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import Combine

final class NickNameInputViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = NickNameInputViewModel()
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nickNameTextField = UITextFieldPadding(top: 14, left: 20, bottom: 14, right: 20)
    private let nextButton = UIView()
    
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
    
    func bindUI() {
        nickNameTextFieldPublisher
            .assign(to: \.nickNameText, on: viewModel)
            .store(in: &cancelBag)
        viewModel.$isTextEmpty
            .sink { [weak self] isTextEmpty in
            }
            .store(in: &cancelBag)
    }
    
    func checkValidCharacter(to string: String) -> Bool {
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
}

extension NickNameInputViewController {
    
    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        
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
        
    }
    
    private func configureLayout() {
        view.addSubview(titleStackView)
        view.addSubview(nickNameTextField)
        view.addSubview(nextButton)
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])
        
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
}
