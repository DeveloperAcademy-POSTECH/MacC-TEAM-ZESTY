//
//  WideBlackButton.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/20.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public final class FullWidthBlackButton: UIButton {
    
    public init() {
        super.init(frame: .zero)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FullWidthBlackButton {
    
    private func configureUI() {
        configuration = .plain()
        configuration?.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        tintColor = .white
        backgroundColor = .black
        clipsToBounds = true
        layer.cornerRadius = 28
    }
    
    private func createLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
    
}
