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
    
    // MARK: Properties
    
    private let viewModel = SignupCompleteViewModel()
    
    private let titleLabel = UILabel()
    private let characterImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let termsOfServiceLabel = UILabel()
    private let startButtonView = ShadowButtonView()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: Function
    
}

extension SignupCompleteViewController {
    
    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "\(viewModel.userName)님,\n환영합니다 🎉"
        titleLabel.font = .systemFont(ofSize: 26)
        titleLabel.numberOfLines = 2
        
        characterImageView.image = UIImage(named: "ZESTER_ONE")
        
        nickNameLabel.text = "\(viewModel.userName)"
        
        termsOfServiceLabel.text = "‘시작하기' 버튼을 누르시면\n이용약관에 동의하시게 됩니다."
        termsOfServiceLabel.textAlignment = .center
        termsOfServiceLabel.numberOfLines = 2
        
        startButtonView.button.setAttributedTitle(NSAttributedString(string: "시작하기", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]), for: .normal)
    }
    
    private func createLayout() {
        view.addSubview(titleLabel)
        view.addSubview(characterImageView)
        view.addSubview(nickNameLabel)
        view.addSubview(termsOfServiceLabel)
        view.addSubview(startButtonView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(120)
            make.height.equalTo(150)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        termsOfServiceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-122)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startButtonView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
        }
    }
    
}
