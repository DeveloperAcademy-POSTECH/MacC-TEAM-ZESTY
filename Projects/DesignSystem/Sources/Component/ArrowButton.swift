//
//  ArrowButton.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

/// 오른쪽 방향의 화살표가 있는 동그란 형태의  UIButton
/// - init(initialDisable: Bool) 로 초기 버튼의 diable 상태를 지정해줄 수 있습니다.
///
/// 높이는 50 point로 설정되어 있습니다.
/// 버튼의 x축 y축 constraints 를 잡아줘야 합니다.
public final class ArrowButton: UIButton {
    
    private let activityIndicator = UIActivityIndicatorView()
    
    public init(initialDisable: Bool = false) {
        super.init(frame: .zero)
        configureUI()
        createLayout()
        setDisabled(initialDisable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setDisabled(_ state: Bool) {
        isUserInteractionEnabled = !state
        tintColor = state ? .disabled : .blackComponent
        layer.borderColor = state ? UIColor.disabled.cgColor : UIColor.blackComponent.cgColor
    }
    
    public func startIndicator() {
        isUserInteractionEnabled = false
        
        imageView?.isHidden = true
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    public func stopIndicator() {
        isUserInteractionEnabled = true
        
        imageView?.isHidden = false
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    public func setBorderColor(_ color: CGColor) {
        layer.borderColor = color
    }
}

extension ArrowButton {
    
    private func configureUI() {
        tintColor = .accent
        backgroundColor = .clear
        configuration = .plain()
        configuration?.contentInsets = .init(top: 14.5, leading: 15, bottom: 14.5, trailing: 15)
        clipsToBounds = true
        layer.borderWidth = 2
        layer.cornerRadius = 25
        
        let arrowImageConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .default)
        let arrowImage = UIImage(systemName: "arrow.forward", withConfiguration: arrowImageConfiguration)
        setImage(arrowImage, for: .normal)
        
        activityIndicator.isHidden = true
    }
    
    private func createLayout() {
        addSubviews([activityIndicator])
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.height.equalTo(50)
        }
    }
    
}
