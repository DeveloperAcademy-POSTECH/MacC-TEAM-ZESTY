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

    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    let superStackView = UIStackView()
    
    private let profileImage = UIImageView()
    private let dividerView = UIView()
    private let emptyView = UIView()
    private let instaButton = UIButton()
    private let mailButton = UIButton()
    private let instaLabel = UILabel()
    private let mailLabel = UILabel()
    
    private var menuView1 = ProfileMenuView()
    private var menuView2 = ProfileMenuView()
    private var menuView3 = ProfileMenuView()
    private var userMenuView1 = ProfileUserMenuView()
    private var userMenuView2 = ProfileUserMenuView()
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
        
        superStackView.axis = .vertical
        superStackView.alignment = .top
        superStackView.distribution = .fillProportionally
        superStackView.spacing = 20
        
        stackView1.axis = .vertical
        stackView1.distribution = .fillEqually

        stackView2.axis = .vertical
        stackView2.distribution = .fillEqually
        
        menuView1.menuLabel.text = "공지사항"
        menuView2.menuLabel.text = "이용약관"
        menuView3.menuLabel.text = "제스티를 만든 사람들"
        
        userMenuView1.userMenuLabel.text = "로그아웃"
        userMenuView2.userMenuLabel.text = "회원탈퇴"
        
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

        profileNickNameView = ProfileNickNameView()
        
    }
    
    private func createLayout() {
        view.addSubviews([profileImage, superStackView, stackView1, stackView2, dividerView, profileNickNameView, instaButton, instaLabel, mailButton, mailLabel])
        superStackView.addArrangedSubviews([stackView1, stackView2])
        stackView1.addArrangedSubviews([menuView1, menuView2, menuView3])
        stackView2.addArrangedSubviews([userMenuView1, userMenuView2, emptyView])
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
        }
        
        superStackView.snp.makeConstraints { make in
            make.top.equalTo(profileNickNameView.snp.bottom).offset(30)
            make.bottom.equalTo(instaButton.snp.top).offset(-68)
            make.leading.trailing.equalToSuperview()
        }
        
        stackView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
//            make.top.equalTo(stackView1.snp.bottom).offset(10)
//            make.bottom.equalTo(stackView2.snp.top).offset(10)
            make.centerY.equalTo(superStackView.snp.centerY)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        stackView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }

        instaButton.snp.makeConstraints { make in
            make.bottom.equalTo(instaLabel.snp.top).offset(-10)
            make.leading.equalToSuperview().inset(115)
            make.trailing.equalToSuperview().inset(215)
//            make.height.equalTo(60)
        }
        
        instaLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(instaButton.snp.centerX)
//            make.height.equalTo(18)
        }
        
//        mailButton.snp.makeConstraints { make in
//            make.centerY.equalTo(instaButton.snp.centerY)
//            make.trailing.equalToSuperview().inset(115)
//            make.leading.equalToSuperview().inset(215)
//            make.height.equalTo(60)
//        }
//
//        mailLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(instaLabel.snp.centerY)
//            make.centerX.equalTo(mailButton.snp.centerX)
//            make.height.equalTo(18)
//        }
        
        profileNickNameView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(136)
        }
    }
    
}
