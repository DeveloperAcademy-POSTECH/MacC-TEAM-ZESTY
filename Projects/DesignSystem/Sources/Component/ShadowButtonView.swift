//
//  shadowButton.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

public final class ShadowButtonView: UIView {
    
    public let button = UIButton()
    private let buttonShadowView = UIView()
    
    public init(initialDisable: Bool = false) {
        super.init(frame: .zero)
        configureUI()
        createLayout()
        setDisable(initialDisable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setDisable(_ state: Bool) {
        button.isEnabled = !state
        button.layer.borderColor = state ? UIColor.lightGray.cgColor : UIColor.black.cgColor
        buttonShadowView.backgroundColor = state ? .lightGray : .black
    }
    
}

extension ShadowButtonView {
    
    private func configureUI() {
        button.tintColor = .white
        button.backgroundColor = .white
        button.configuration = .filled()
        button.configuration?.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 18
        
        buttonShadowView.backgroundColor = .black
        buttonShadowView.clipsToBounds = true
        buttonShadowView.layer.cornerRadius = 18
    }
    
    private func createLayout() {
        addSubview(buttonShadowView)
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
        }
        
        buttonShadowView.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.trailing).offset(-4)
            make.top.equalTo(button.snp.top).offset(4)
            make.width.equalTo(button.snp.width)
            make.height.equalTo(button.snp.height)
        }
    }
    
}
