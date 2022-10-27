//
//  ProfileViewController.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let profileImageView = UIImageView()
    private let profileMenuSuperStackView = UIStackView()
    private let profileMenuStackView = UIStackView()
    private let dividerView = UIView()
    private let profileUserMenuStackView = UIStackView()
    private let emptyView = UIView()
    private let instaButton = UIButton()
    private let mailButton = UIButton()
    private let instaLabel = UILabel()
    private let mailLabel = UILabel()
    
    private var profileNickNameView = ProfileNickNameView()
    private var profileMenuView1 = ProfileMenuView(menuText: "공지사항")
    private var profileMenuView2 = ProfileMenuView(menuText: "이용약관")
    private var profileMenuView3 = ProfileMenuView(menuText: "제스티를 만든 사람들")
    private var profileUserMenuView1 = ProfileUserMenuView(userMenuText: "로그아웃")
    private var profileUserMenuView2 = ProfileUserMenuView(userMenuText: "회원탈퇴")

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
        
        profileImageView.image = UIImage(.img_signup)
        profileImageView.contentMode = .scaleAspectFit
        
        profileMenuSuperStackView.axis = .vertical
        profileMenuSuperStackView.alignment = .top
        profileMenuSuperStackView.distribution = .fillProportionally
        profileMenuSuperStackView.spacing = 20
        
        profileMenuStackView.axis = .vertical
        profileMenuStackView.distribution = .fillEqually

        profileUserMenuStackView.axis = .vertical
        profileUserMenuStackView.distribution = .fillEqually
        
        dividerView.backgroundColor = .zestyColor(.grayF6)

        instaButton.setImage(UIImage(.btn_link_instargram), for: .normal)
        
        instaLabel.text = "인스타"
        instaLabel.textColor = .black
        instaLabel.font = .systemFont(ofSize: 13, weight: .regular)
        instaLabel.textAlignment = .center
        instaLabel.numberOfLines = 1

        mailButton.setImage(UIImage(.btn_link_mail), for: .normal)

        mailLabel.text = "문의"
        mailLabel.textColor = .black
        mailLabel.font = .systemFont(ofSize: 13, weight: .regular)
        mailLabel.textAlignment = .center
        mailLabel.numberOfLines = 1
        
    }
    
    private func createLayout() {
        view.addSubviews([profileImageView, profileNickNameView, profileMenuSuperStackView, dividerView, instaButton, instaLabel, mailButton, mailLabel])
        profileMenuSuperStackView.addArrangedSubviews([profileMenuStackView, profileUserMenuStackView])
        profileMenuStackView.addArrangedSubviews([profileMenuView1, profileMenuView2, profileMenuView3])
        profileUserMenuStackView.addArrangedSubviews([profileUserMenuView1, profileUserMenuView2, emptyView])
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
        }
        
        profileNickNameView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        profileMenuSuperStackView.snp.makeConstraints { make in
            make.top.equalTo(profileNickNameView.snp.bottom).offset(30)
            make.bottom.equalTo(instaButton.snp.top).offset(-68)
            make.leading.trailing.equalToSuperview()
        }
        
        profileMenuStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.centerY.equalTo(profileMenuSuperStackView.snp.centerY)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        profileUserMenuStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }

        instaButton.snp.makeConstraints { make in
            make.bottom.equalTo(instaLabel.snp.top).offset(-10)
            make.leading.equalToSuperview().inset(115)
        }
        
        instaLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(instaButton.snp.centerX)
        }
        
        mailButton.snp.makeConstraints { make in
            make.centerY.equalTo(instaButton.snp.centerY)
            make.trailing.equalToSuperview().inset(115)
        }

        mailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(mailButton.snp.centerX)
        }
        
    }
    
}
