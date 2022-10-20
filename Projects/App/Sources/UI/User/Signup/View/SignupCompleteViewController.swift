//
//  SignupCompleteViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem

final class SignupCompleteViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = SignupCompleteViewModel()
    
    private let titleLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let termsOfServiceLabel = UILabel()
    private let startButtonView = ArrowButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc private func termsOfServiceLabelClicked() {
        
    }
    
}

// MARK: - UI Function

extension SignupCompleteViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "\(viewModel.userName)님,\n환영합니다 🎉"
        titleLabel.font = .systemFont(ofSize: 26)
        titleLabel.numberOfLines = 2
        
        backgroundImageView.image = UIImage(.img_signup)
        
        nickNameLabel.text = "\(viewModel.userName)"
        nickNameLabel.font = .preferredFont(forTextStyle: .headline)
        
        let termsOfServiceLabelText = "‘시작하기' 버튼을 누르시면\n이용약관에 동의하시게 됩니다."
        let attributedText = NSMutableAttributedString(string: termsOfServiceLabelText,
                                                       attributes: [.font: UIFont.preferredFont(forTextStyle: .footnote)])
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: (termsOfServiceLabelText as NSString).range(of: "이용약관"))
        termsOfServiceLabel.attributedText = attributedText
        termsOfServiceLabel.textAlignment = .center
        termsOfServiceLabel.numberOfLines = 2
        termsOfServiceLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsOfServiceLabelClicked)))
        termsOfServiceLabel.isUserInteractionEnabled = true
        
    }
    
    private func createLayout() {
        view.addSubviews([titleLabel, backgroundImageView, nickNameLabel, termsOfServiceLabel, startButtonView])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(127)
            make.height.equalTo(127)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        termsOfServiceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(startButtonView.snp.top).offset(-16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startButtonView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
        }
    }
    
}
