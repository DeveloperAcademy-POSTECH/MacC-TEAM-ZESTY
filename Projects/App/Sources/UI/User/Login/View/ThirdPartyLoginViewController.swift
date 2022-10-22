//
//  ProfilePlaceHolder.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/07.
//  Copyright © 2022 zesty. All rights reserved.
//

import AuthenticationServices
import UIKit
import DesignSystem
import SnapKit

final class ThirdPartyLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let loginStackView = UIStackView()
    private let termsOfServiceLabel = UILabel()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc private func termsOfServiceLabelClicked() {
        
    }
    
    @objc func kakaoLoginButtonClicked() {
        navigationController?.pushViewController(NickNameInputViewController(), animated: true)
    }
    
    @objc func appleLoginButtonClicked() {
        navigationController?.pushViewController(NickNameInputViewController(), animated: true)
    }
    
}

// MARK: - UI Function

extension ThirdPartyLoginViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 12
        
        titleLabel.text = "안녕하세요,\n제스티입니다"
        titleLabel.font = .systemFont(ofSize: 26)
        titleLabel.numberOfLines = 2
        
        subtitleLabel.text = "로그인하여 모든 맛집을 확인하세요."
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .preferredFont(forTextStyle: .callout)
        
        backgroundImageView.image = UIImage(.img_login)
        backgroundImageView.contentMode = .scaleAspectFit
        
        loginStackView.axis = .vertical
        loginStackView.spacing = 20
        
        let termsOfServiceLabelText = "‘계속하기' 버튼을 누르시면\n이용약관에 동의하시게 됩니다."
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
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonClicked), for: .touchUpInside)
        kakaoLoginButton.setImage(UIImage(.btn_kakaologin), for: .normal)
        kakaoLoginButton.imageView?.contentMode = .scaleAspectFill
        
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        appleLoginButton.setImage(UIImage(.btn_applelogin), for: .normal)
        appleLoginButton.imageView?.contentMode = .scaleAspectFill
    }
    
    private func createLayout() {
        view.addSubviews([titleStackView, backgroundImageView, termsOfServiceLabel, loginStackView])
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])
        loginStackView.addArrangedSubviews([kakaoLoginButton, appleLoginButton])
        
        titleStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.height.equalTo(140)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleStackView.snp.bottom).offset(88)
            make.bottom.equalTo(termsOfServiceLabel.snp.bottom).offset(-100)
        }
        
        termsOfServiceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(loginStackView.snp.top).offset(-20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
}
