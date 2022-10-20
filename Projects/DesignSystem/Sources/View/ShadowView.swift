//
//  ShadowView.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

public final class ShadowView: UIView {
    
    private lazy var stackView = UIStackView()
    
    private lazy var contentView: UIView = {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    private lazy var shadowView: UIView = {
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShadowView {

    private func configureUI() {

    }

    private func createLayout() {
        addSubviews([contentView, shadowView])
        bringSubviewToFront(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        shadowView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(-4)
            $0.top.equalTo(contentView.snp.top).offset(4)
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalTo(contentView.snp.height)
        }
    }

}
