//
//  shadowButton.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

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
        tintColor = state ? .lightGray : .black
        layer.borderColor = state ? UIColor.lightGray.cgColor : UIColor.black.cgColor
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
}

extension ArrowButton {
    
    private func configureUI() {
        tintColor = .black
        backgroundColor = .white
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
        }
    }
    
}
