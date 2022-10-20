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
        configuration?.contentInsets = .init(top: 17, leading: 0, bottom: 17, trailing: 0)
        tintColor = .white
        backgroundColor = .black
        clipsToBounds = true
        layer.cornerRadius = 27
    }
    
    private func createLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
    
}
