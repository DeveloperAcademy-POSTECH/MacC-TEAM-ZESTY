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
    
    private var profileNickNameView = ProfileNickNameView()
    private var profileMenuView1 = ProfileMenuView(menuText: "공지사항")
    private var profileMenuView2 = ProfileMenuView(menuText: "이용약관")
    private var profileMenuView3 = ProfileMenuView(menuText: "제스티를 만든 사람들")
    private var profileUserMenuView1 = ProfileUserMenuView(userMenuText: "로그아웃")
    private var profileUserMenuView2 = ProfileUserMenuView(userMenuText: "회원탈퇴")
    private var profileLinkButtonView = ProfileLinkButtonView()
    private var profileLinkLabelView = ProfileLinkLabelView()

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
        profileMenuSuperStackView.alignment = .leading
        profileMenuSuperStackView.distribution = .fillProportionally
        profileMenuSuperStackView.spacing = 10
        
        profileMenuStackView.axis = .vertical
        profileMenuStackView.distribution = .fillEqually
        profileMenuStackView.spacing = 0

        profileUserMenuStackView.axis = .vertical
        profileUserMenuStackView.distribution = .fillEqually
        profileUserMenuStackView.spacing = 0
        
        dividerView.backgroundColor = .zestyColor(.grayF6)
    }
    
    private func createLayout() {
        view.addSubviews([profileImageView, profileNickNameView, profileMenuSuperStackView, profileLinkButtonView, profileLinkLabelView])
        profileMenuSuperStackView.addArrangedSubviews([profileMenuStackView, dividerView, profileUserMenuStackView])
        profileMenuStackView.addArrangedSubviews([profileMenuView1, profileMenuView2, profileMenuView3])
        profileUserMenuStackView.addArrangedSubviews([profileUserMenuView1, profileUserMenuView2])
        
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
            make.leading.trailing.equalToSuperview()
        }
        
        profileMenuStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        profileUserMenuStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        profileLinkButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(profileLinkLabelView.snp.top).offset(-10)
        }

        profileLinkLabelView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-3)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
    }
    
}
