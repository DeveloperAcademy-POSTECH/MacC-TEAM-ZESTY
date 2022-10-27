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
///
/// 높이는 최소 94 point로 정해져 있습니다.
///
/// top constraint와 너비만 지정해주면 됩니다
public final class MainTitleView: UIView {
    public var titleLabel = UILabel()
    public var subtitleLabel = UILabel()
    private let titleStackView = UIStackView()
    
    public init(title: String = "", subtitle: String = "") {
        super.init(frame: .zero)
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        configureUI(subTitle: subtitle)
        createLayout(subtitle: subtitle)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTitleView {
    
    private func configureUI(subTitle: String) {
        titleStackView.spacing = 12
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        
        if !subTitle.isEmpty {
            subtitleLabel.textColor = .secondaryLabel
            subtitleLabel.numberOfLines = 0
            subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    private func createLayout(subtitle: String) {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        if !subtitle.isEmpty {
            titleStackView.addArrangedSubview(subtitleLabel)
            
            subtitleLabel.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
            }
        }
    }
    
}
