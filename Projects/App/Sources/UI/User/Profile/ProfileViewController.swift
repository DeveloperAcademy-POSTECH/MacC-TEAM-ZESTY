//
//  ProfileViewController.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties

    private let profileImage = UIImageView()
    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    private let dividerView = UIView()
    private var profileMenu1 = ProfileMenuView()
    private var profileMenu2 = ProfileMenuView()
    private var profileMenu3 = ProfileMenuView()
    private var profileMenu4 = ProfileMenuView()
    private var profileMenu5 = ProfileMenuView()
    private let instaButton = UIButton()
    private let mailButton = UIButton()
    private let instaLink = UILabel()
    private let mailLink = UILabel()
    private var profileNickNameView = ProfileNickNameView()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension ProfileViewController {
    
    private func configureUI() {
        view.backgroundColor = .zestyColor(.background)
        
        profileImage.image = UIImage(.img_signup)
        profileImage.contentMode = .scaleAspectFit
        
        stackView1.axis = .vertical
        stackView1.alignment = .fill
        stackView1.distribution = .fillEqually

        stackView2.axis = .vertical
        stackView2.alignment = .fill
        stackView2.distribution = .fillEqually
        
        profileMenu1.menuLabel.text = "공지사항"
        profileMenu2.menuLabel.text = "이용약관"
        profileMenu3.menuLabel.text = "제스티를 만든 사람들"
        profileMenu4.menuLabel.text = "로그아웃"
        profileMenu5.menuLabel.text = "회원탈퇴"
        
        dividerView.backgroundColor = .zestyColor(.grayF6)

        instaButton.setImage(UIImage(.btn_link_instargram), for: .normal)
        
        instaLink.text = "인스타"
        instaLink.textColor = .black
        instaLink.font = .systemFont(ofSize: 13, weight: .regular)
        instaLink.textAlignment = .center
        instaLink.numberOfLines = 1

        mailButton.setImage(UIImage(.btn_link_mail), for: .normal)

        mailLink.text = "문의"
        mailLink.textColor = .black
        mailLink.font = .systemFont(ofSize: 13, weight: .regular)
        mailLink.textAlignment = .center
        mailLink.numberOfLines = 1

        profileNickNameView = ProfileNickNameView()
        
    }
    
    private func createLayout() {
        view.addSubviews([profileImage, stackView1, dividerView, stackView2, profileNickNameView, instaButton, instaLink, mailButton, mailLink])
        stackView1.addArrangedSubviews([profileMenu1, profileMenu2, profileMenu3])
        stackView2.addArrangedSubviews([profileMenu4, profileMenu5])
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
        }
        
        stackView1.snp.makeConstraints { make in
            make.top.equalTo(profileNickNameView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(dividerView.snp.top).offset(-10)
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        stackView2.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(instaButton.snp.top).offset(-68)
        }

        instaLink.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(instaButton.snp.centerX)
        }
        
        instaButton.snp.makeConstraints { make in
            make.bottom.equalTo(instaLink.snp.top).offset(-10)
            make.leading.equalToSuperview().inset(115)
            make.trailing.equalToSuperview().inset(215)
            make.width.equalTo(60)
        }
        
        mailLink.snp.makeConstraints { make in
            make.bottom.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(mailButton.snp.centerX)
        }
        
        mailButton.snp.makeConstraints { make in
            make.bottom.equalTo(instaLink.snp.top).offset(-10)
            make.trailing.equalToSuperview().inset(115)
            make.leading.equalToSuperview().inset(215)
            make.width.equalTo(60)
        }
        
        profileNickNameView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(136)
        }
    }
    
}
