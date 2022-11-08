//
//  ProfileViewController.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import Firebase
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = ProfileViewModel()
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let profileImageView = UIImageView()
    private let profileMenuSuperStackView = UIStackView()
    private let profileMenuStackView = UIStackView()
    private let dividerView = UIView()
    private let profileUserMenuStackView = UIStackView()
    
    private lazy var profileNickNameView = ProfileNickNameView(viewModel: viewModel)
    private var profileMenuView1 = ProfileMenuView(menuText: "공지사항")
    private var profileMenuView2 = ProfileMenuView(menuText: "약관 및 정책")
    private var profileMenuView3 = ProfileMenuView(menuText: "제스티를 만든 사람들")
    private var profileUserLogoutView = ProfileUserMenuView(userMenuText: "로그아웃")
    private var profileUserWithdrawalView = ProfileUserMenuView(userMenuText: "회원탈퇴")
    private var profileLinkButtonView = ProfileLinkButtonView()
    private var profileLinkLabelView = ProfileLinkLabelView()
    
    private lazy var logoutSheet: UIAlertController = {
        $0.addAction(UIAlertAction(title: "네", style: .destructive,
            handler: { [weak self] _ in
            self?.viewModel.userLogout()
        }))
        $0.addAction(UIAlertAction(title: "아니오", style: .cancel))
        return $0
    }(UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert))
    
    private lazy var withdrawalSheet: UIAlertController = {
        $0.addAction(UIAlertAction(title: "네", style: .destructive,
            handler: { [weak self] _ in
            self?.viewModel.userWithdrawl()
        }))
        $0.addAction(UIAlertAction(title: "아니오", style: .cancel))
        return $0
    }(UIAlertController(title: "회원탈퇴", message: "회원탈퇴 하시겠습니까?", preferredStyle: .alert))

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bindUI()
        analytics()
    }
    
    // MARK: - Function
    
    private func analytics() {
        FirebaseAnalytics.Analytics.logEvent("profile_screen_viewed", parameters: [
            AnalyticsParameterScreenName: "profile"
        ])
    }
        
    @objc private func userLogout() {
        present(logoutSheet, animated: true)
    }
    
    @objc private func userWithdrawal() {
        present(withdrawalSheet, animated: true)
    }
    
    @objc func profileMenuTap1(sender: UITapGestureRecognizer) {
        profileMenuView1.showAnimation {
            UrlUtils.openExternalLink(urlStr: "https://avery-in-ada.notion.site/5bf82d07f7ff4f3aa2d5d86a826baf7e")
        }
    }
    
    @objc func profileMenuTap2(sender: UITapGestureRecognizer) {
        profileMenuView2.showAnimation {
            UrlUtils.openExternalLink(urlStr: "https://avery-in-ada.notion.site/bc452553120c48e986541111425ebb7d")
        }
    }
    
    @objc func profileMenuTap3(sender: UITapGestureRecognizer) {
        profileMenuView3.showAnimation {
            UrlUtils.openExternalLink(urlStr: "https://avery-in-ada.notion.site/323bf511fcb3473a961a8735f8dd2c57")
        }
    }
    
}

// MARK: - BindUI

extension ProfileViewController {
    
    private func bindUI() {
        viewModel.isUserLoggedOutSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            }
            .store(in: &cancelBag)
        
        viewModel.changeNickNameImageViewClicked
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.navigationController?.pushViewController(NickNameInputViewController(state: .profile, profileViewModel: self?.viewModel), animated: true)
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function

extension ProfileViewController {
    
    private func configureUI() {
        view.backgroundColor = .zestyColor(.background)
        
        navigationItem.title = "프로필"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
        profileImageView.image = UIImage(.img_signup)
        profileImageView.contentMode = .scaleAspectFit

        profileMenuSuperStackView.axis = .vertical
        profileMenuSuperStackView.alignment = .leading
        profileMenuSuperStackView.distribution = .fillProportionally
        profileMenuSuperStackView.spacing = 10
        
        profileMenuStackView.axis = .vertical
        profileMenuStackView.distribution = .fillEqually
        profileMenuStackView.spacing = 0
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(profileMenuTap1(sender:)))
        profileMenuView1.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(profileMenuTap2(sender:)))
        profileMenuView2.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(profileMenuTap3(sender:)))
        profileMenuView3.addGestureRecognizer(tapGesture3)

        profileUserMenuStackView.axis = .vertical
        profileUserMenuStackView.distribution = .fillEqually
        profileUserMenuStackView.spacing = 0
        
        profileUserLogoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userLogout)))
        profileUserLogoutView.isUserInteractionEnabled = true
        
        profileUserWithdrawalView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userWithdrawal)))
        profileUserWithdrawalView.isUserInteractionEnabled = true
        
        dividerView.backgroundColor = .zestyColor(.grayF6)
    }
    
    private func createLayout() {
        view.addSubviews([profileImageView, profileNickNameView, profileMenuSuperStackView, profileLinkButtonView, profileLinkLabelView])
        profileMenuSuperStackView.addArrangedSubviews([profileMenuStackView, dividerView, profileUserMenuStackView])
        profileMenuStackView.addArrangedSubviews([profileMenuView1, profileMenuView2, profileMenuView3])
        profileUserMenuStackView.addArrangedSubviews([profileUserLogoutView, profileUserWithdrawalView])
        
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
