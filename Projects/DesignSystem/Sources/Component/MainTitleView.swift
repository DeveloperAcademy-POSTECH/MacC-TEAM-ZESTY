//
//  MainTitleView.swift
//  DesignSystem
//
//  Created by 김태호 on 2022/10/20.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

/// Main Title을 만들기 위한 UIView
/// - title: 화면의 타이틀에 들어갈 문자열
/// - subtitle: (옵셔널) 화면의 타이틀 밑에 들어갈 회색의 문자열
public final class MainTitleView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    public init(title: String, subtitle: String? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTitleView {
    
    private func configureUI() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private func createLayout() {
        addSubviews([titleLabel, subtitleLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
}
