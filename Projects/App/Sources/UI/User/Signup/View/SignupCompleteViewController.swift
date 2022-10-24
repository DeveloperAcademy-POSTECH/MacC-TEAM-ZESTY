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
    
    private let titleLabel = MainTitleView(title: "고반님\n환영합니다🎉")
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

        backgroundImageView.image = UIImage(.img_signup)
        
        nickNameLabel.text = "\(viewModel.userName)"
        nickNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        startButton.setAttributedTitle(NSMutableAttributedString(string: "우리 대학 맛집여정에 함께하기",
                                                                     attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]), for: .normal)
    }
    
    private func createLayout() {
        view.addSubviews([titleLabel, backgroundImageView, nickNameLabel, startButton])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(130)
            make.width.equalTo(130)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}

#if DEBUG
import SwiftUI
struct SignupCompleteViewTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        SignupCompleteViewController().toPreview()
    }

}
#endif
