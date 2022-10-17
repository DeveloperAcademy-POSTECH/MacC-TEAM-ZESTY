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
    
    private lazy var placeView: UIView = {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    private lazy var placeShadowView: UIView = {
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    public init(initialDisable: Bool = false) {
        super.init(frame: .zero)
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
        addSubviews([placeView, placeShadowView])
        bringSubviewToFront(placeView)

        placeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        placeShadowView.snp.makeConstraints {
            $0.leading.equalTo(placeView.snp.leading).offset(-4)
            $0.top.equalTo(placeView.snp.top).offset(4)
            $0.width.equalTo(placeView.snp.width)
            $0.height.equalTo(placeView.snp.height)
        }
    }

}
