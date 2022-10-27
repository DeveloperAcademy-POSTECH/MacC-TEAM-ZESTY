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

    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    let superStackView = UIStackView()
    let nickNameStackView = UIStackView()
    
    private let profileImage = UIImageView()
    private let dividerView = UIView()
    private let emptyView = UIView()
    private let instaButton = UIButton()
    private let mailButton = UIButton()
    private let instaLabel = UILabel()
    private let mailLabel = UILabel()
    
    private var menuView1 = ProfileMenuView(menuText: "공지사항")
    private var menuView2 = ProfileMenuView(menuText: "이용약관")
    private var menuView3 = ProfileMenuView(menuText: "제스티를 만든 사람들")
    private var userMenuView1 = ProfileUserMenuView(userMenuText: "로그아웃")
    private var userMenuView2 = ProfileUserMenuView(userMenuText: "회원탈퇴")
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
        
        nickNameStackView.axis = .horizontal
        nickNameStackView.alignment = .center
        nickNameStackView.distribution = .fillProportionally
        nickNameStackView.spacing = 10
        
        superStackView.axis = .vertical
        superStackView.alignment = .top
        superStackView.distribution = .fillProportionally
        superStackView.spacing = 20
        
        stackView1.axis = .vertical
        stackView1.distribution = .fillEqually

        stackView2.axis = .vertical
        stackView2.distribution = .fillEqually
        
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
        view.addSubviews([profileImage, nickNameStackView, superStackView, stackView1, stackView2, dividerView, instaButton, instaLabel, mailButton, mailLabel])
        nickNameStackView.addArrangedSubview(profileNickNameView)
        superStackView.addArrangedSubviews([stackView1, stackView2])
        stackView1.addArrangedSubviews([menuView1, menuView2, menuView3])
        stackView2.addArrangedSubviews([userMenuView1, userMenuView2, emptyView])
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
        }
        
        nickNameStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        superStackView.snp.makeConstraints { make in
            make.top.equalTo(nickNameStackView.snp.bottom).offset(30)
            make.bottom.equalTo(instaButton.snp.top).offset(-68)
            make.leading.trailing.equalToSuperview()
        }
        
        stackView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
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
