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
        
        profileNickNameView = ProfileNickNameView()
        
    }
    
    private func createLayout() {
        view.addSubview(profileImage)
        view.addSubview(profileNickNameView)
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
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
