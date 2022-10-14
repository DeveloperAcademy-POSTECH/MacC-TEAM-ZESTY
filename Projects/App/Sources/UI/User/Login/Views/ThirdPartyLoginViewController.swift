//
//  ProfilePlaceHolder.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/07.
//  Copyright © 2022 zesty. All rights reserved.
//

import AuthenticationServices
import UIKit
import SnapKit
import DesignSystem

final class ThirdPartyLoginViewController: UIViewController {
    
    // MARK: Properties
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let characterImageView = UIImageView()
    private let loginStackView = UIStackView()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        configureUI()
        configureLayout()
    }
    
    // MARK: Function
    
    @objc func kakaoLoginButtonClicked() {
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
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 12
        
        titleLabel.text = "반가워요, ZESTER"
        titleLabel.font = .systemFont(ofSize: 26)
        
        subtitleLabel.text = "로그인하여 모든 맛집을 확인하세요."
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .preferredFont(forTextStyle: .callout)
        
        characterImageView.image = UIImage(.img_zesterthree)
        
        loginStackView.axis = .vertical
        loginStackView.spacing = 20
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonClicked), for: .touchUpInside)
        kakaoLoginButton.setImage(UIImage(.btn_kakaologin), for: .normal)
        
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        appleLoginButton.setImage(UIImage(.btn_applelogin), for: .normal)
    }
    
    private func configureLayout() {
        view.addSubview(titleStackView)
        view.addSubview(characterImageView)
        view.addSubview(loginStackView)
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])
        loginStackView.addArrangedSubviews([kakaoLoginButton, appleLoginButton])
        
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
            make.top.equalTo(characterImageView.snp.bottom).offset(158)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
}
