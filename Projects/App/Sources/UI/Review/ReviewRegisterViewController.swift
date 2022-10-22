//
//  ReviewRegisterViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import DesignSystem
import SnapKit

final class ReviewRegisterViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    
    private let titleView = UIView()
    private let containerView = UIView()
    private let backgroundView = UIView()
    private let plusImageView = UIImageView()
    private let imageButton = UIButton()
    private let menuTextField = UITextField()
    private let underline = UIView()
    private let registerButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        createLayout()
    }

    // MARK: - Function
    
}

// MARK: - UI Function

extension ReviewRegisterViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.backButtonDisplayMode = .minimal
        
        titleView.backgroundColor = .gray

        var config = UIImage.SymbolConfiguration(paletteColors: [.darkGray])
        config = config.applying(UIImage.SymbolConfiguration(weight: .semibold) )
        let plusImage = UIImage(systemName: "plus", withConfiguration: config)
        plusImageView.image = plusImage
        backgroundView.backgroundColor = .zestyColor(.grayF6)
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        imageButton.clipsToBounds = true
        imageButton.layer.cornerRadius = 10
        
        menuTextField.placeholder = "음식 이름"
        menuTextField.textAlignment = .center
        menuTextField.layer.masksToBounds = true
        
        underline.clipsToBounds = true
        underline.layer.cornerRadius = 1
        underline.backgroundColor = .black
        
        registerButton.setTitle("사진 없이 리뷰 등록", for: .normal)
    }
    
    private func createLayout() {
        view.addSubviews([titleView, containerView, registerButton])
        containerView.addSubviews([backgroundView, plusImageView,
                                       imageButton, menuTextField, underline])
        
        titleView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(135)
        }
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalTo(containerView.snp.height).multipliedBy(0.75)
        }
        backgroundView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(backgroundView.snp.width)
        }
        plusImageView.snp.makeConstraints {
            $0.center.equalTo(backgroundView.snp.center)
            $0.width.height.equalTo(35)
        }
        imageButton.snp.makeConstraints {
            $0.edges.equalTo(backgroundView.snp.edges)
        }
        menuTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backgroundView.snp.bottom).offset(30)
            $0.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualTo(30)
            $0.width.lessThanOrEqualTo(view.snp.width).inset(40)
        }
        underline.snp.makeConstraints {
            $0.leading.equalTo(menuTextField.snp.leading).offset(-10)
            $0.trailing.equalTo(menuTextField.snp.trailing).offset(10)
            $0.bottom.equalTo(menuTextField.snp.bottom).offset(5)
            $0.height.equalTo(3)
        }
        registerButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
        }
    }
    
}

// MARK: - Previews

struct ReviewRegisterPreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: ReviewRegisterViewController()).toPreview()
    }
    
}
