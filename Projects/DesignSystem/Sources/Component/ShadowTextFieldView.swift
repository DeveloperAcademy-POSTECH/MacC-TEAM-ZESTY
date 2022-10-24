//
//  ShadowTextFieldView.swift
//  DesignSystem
//
//  Created by 김태호 on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

public final class ShadowTextFieldView: UIView {
    public let textField = UITextField()
    private let leftImage = UIImageView()
    private let backgroundView = UIView()
    private let shadowView = UIView()
    private let cornerRadius: CGFloat = 22.5
    
    public init() {
        super.init(frame: .zero)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShadowTextFieldView {
    private func configureUI() {
        textField.placeholder = "대학교 검색"
        textField.returnKeyType = .next
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .default)
        leftImage.image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
        leftImage.tintColor = .gray
        
        backgroundView.backgroundColor = .white
        backgroundView.layer.borderWidth = 2
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.clipsToBounds = true
        
        shadowView.backgroundColor = .black
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.clipsToBounds = true
    }
    
    private func createLayout() {
        addSubviews([shadowView, backgroundView, leftImage, textField])
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(leftImage.snp.right).offset(8)
        }
        
        leftImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        shadowView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(4)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
