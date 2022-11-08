//
//  SignupCompleteViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import Firebase

final class SignupCompleteViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = SignupCompleteViewModel()
    
    private lazy var titleLabel = MainTitleView(title: "\(viewModel.userName)님\n환영합니다🎉")
    private let backgroundImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let startButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        analytics()
    }
    
    // MARK: - Function
    
    @objc private func startButtonClicked() {
        navigationController?.pushViewController(PlaceListViewController(), animated: true)
    }
    
}

// MARK: - UI Function

extension SignupCompleteViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        backgroundImageView.image = UIImage(.img_signup)
        
        nickNameLabel.text = "\(viewModel.userName)"
        nickNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        startButton.setTitle("우리 대학 맛집여정에 함께하기", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
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
