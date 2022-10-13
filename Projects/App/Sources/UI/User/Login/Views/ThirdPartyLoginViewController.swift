//
//  ProfilePlaceHolder.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/07.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit
import AuthenticationServices

final class ThirdPartyLoginViewController: UIViewController {
    
    // MARK: Properties
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let characterImageView = UIImageView()
    private let loginStackView = UIStackView()
    private let kakaoLoginImageView = UIImageView()
    private let appleLoginButton = ASAuthorizationAppleIDButton(type: .signUp, style: .black)
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        configureUI()
        configureLayout()
    }
    
    // MARK: Function
    
    @objc func kakaoLoginImageViewClicked() {
        navigationController?.pushViewController(NickNameInputViewController(), animated: true)
    }
    
    @objc func appleLoginButtonClicked() {
        navigationController?.pushViewController(NickNameInputViewController(), animated: true)
    }
    
}

extension ThirdPartyLoginViewController {
    
    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 12
        
        titleLabel.text = "반가워요, ZESTER"
        titleLabel.font = .systemFont(ofSize: 26)
        
        subtitleLabel.text = "로그인하여 모든 맛집을 확인하세요."
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .preferredFont(forTextStyle: .callout)
        
        characterImageView.image = UIImage(named: "ZESTER_THREE")
        
        loginStackView.axis = .vertical
        loginStackView.spacing = 20
        
        kakaoLoginImageView.image = UIImage(named: "KakaoLogin")
        kakaoLoginImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(kakaoLoginImageViewClicked)))
        
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
    }
    
    private func configureLayout() {
        view.addSubview(titleStackView)
        view.addSubview(characterImageView)
        view.addSubview(loginStackView)
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])
        loginStackView.addArrangedSubviews([kakaoLoginImageView, appleLoginButton])
        
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(212)
            make.height.equalTo(100)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
        }
    }
    
}
