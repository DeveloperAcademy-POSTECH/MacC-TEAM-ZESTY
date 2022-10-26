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
        
        instaButton.setImage(UIImage(.btn_insta), for: .normal)
        
        instaLink.text = "인스타"
        instaLink.textColor = .black
        instaLink.font = .systemFont(ofSize: 13, weight: .regular)
        instaLink.textAlignment = .center
        instaLink.numberOfLines = 1

        mailButton.setImage(UIImage(.btn_mail), for: .normal)

        mailLink.text = "문의"
        mailLink.textColor = .black
        mailLink.font = .systemFont(ofSize: 13, weight: .regular)
        mailLink.textAlignment = .center
        mailLink.numberOfLines = 1

        profileNickNameView = ProfileNickNameView()
        
    }
    
    private func createLayout() {
        view.addSubviews([profileImage, profileNickNameView, instaButton, instaLink, mailButton, mailLink])
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
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

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ProfilePreview: PreviewProvider {
    
    static var previews: some View {
        ProfileViewController().toPreview()
    }
    
}
#endif
