//
//  shadowButton.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

class ShadowButton: UIView {
    
    private let nextButton = UIButton()
    private let nextButtonShadowUIView = UIView()
    
    init() {
        super.init(frame: .zero)
        configureUI()
        createLayout()
        setDisable(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDisable(_ state: Bool) {
        nextButton.isEnabled = !state
        nextButton.tintColor = state ? .lightGray : .white
        nextButton.layer.borderColor = state ? UIColor.lightGray.cgColor : UIColor.black.cgColor
        nextButtonShadowUIView.backgroundColor = state ? .lightGray : .black
    }
    
}

extension ShadowButton {
    
    private func configureUI() {
        nextButton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]), for: .normal)
        nextButton.backgroundColor = .white
        nextButton.configuration = .filled()
        nextButton.configuration?.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        let arrowImageconfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular, scale: .default)
        let arrowImage = UIImage(systemName: "arrow.forward", withConfiguration: arrowImageconfiguration)
        nextButton.setImage(arrowImage, for: .normal)
        nextButton.semanticContentAttribute = .forceRightToLeft
        nextButton.clipsToBounds = true
        nextButton.layer.borderWidth = 2
        nextButton.layer.cornerRadius = 18
        
        nextButtonShadowUIView.backgroundColor = .black
        nextButtonShadowUIView.clipsToBounds = true
        nextButtonShadowUIView.layer.cornerRadius = 18
    }
    
    private func createLayout() {
        addSubview(nextButton)
        addSubview(nextButtonShadowUIView)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.trailing.equalTo(snp.trailing)
        }
        
        nextButtonShadowUIView.snp.makeConstraints { make in
            make.trailing.equalTo(nextButton.snp.trailing).offset(-4)
            make.top.equalTo(nextButton.snp.top).offset(4)
            make.width.equalTo(nextButton.snp.width)
            make.height.equalTo(nextButton.snp.height)
        }
        nextButtonShadowUIView.sendSubviewToBack(nextButton)
    }
    
}
