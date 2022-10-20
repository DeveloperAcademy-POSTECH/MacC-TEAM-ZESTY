//
//  SignupCompleteViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem

final class SignupCompleteViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = SignupCompleteViewModel()
    
    private let titleLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let startButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension SignupCompleteViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "\(viewModel.userName)님,\n환영합니다 🎉"
        titleLabel.font = .systemFont(ofSize: 26)
        titleLabel.numberOfLines = 2
        
        backgroundImageView.image = UIImage(.img_signup)
        
        nickNameLabel.text = "\(viewModel.userName)"
        nickNameLabel.font = .preferredFont(forTextStyle: .headline)
        
        startButton.setAttributedTitle(NSMutableAttributedString(string: "우리 대학 맛집여정에 함께하기",
                                                                     attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]), for: .normal)
    }
    
    private func createLayout() {
        view.addSubviews([titleLabel, backgroundImageView, nickNameLabel, startButton])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(127)
            make.height.equalTo(127)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(nickNameLabel.snp.bottom).offset(203)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}
