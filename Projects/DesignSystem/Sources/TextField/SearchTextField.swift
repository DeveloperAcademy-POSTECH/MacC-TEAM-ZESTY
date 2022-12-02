//
//  SearchTextField.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//
import UIKit
import SnapKit

public final class SearchTextField: UIView {
    public var placeholder: String
    
    public let textField = UITextField()
    private let leftImage = UIImageView()
    private let backgroundView = UIView()
    private let cornerRadius: CGFloat = 45/2
    
    public init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTextField {
    private func configureUI() {
        textField.placeholder = placeholder
        textField.clearButtonMode = .always
        textField.returnKeyType = .search
        textField.textColor = .label
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        backgroundView.layer.borderWidth = 2
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.borderColor = UIColor.blackComponent.cgColor
        backgroundView.clipsToBounds = true
    }
    
    private func createLayout() {
        addSubviews([backgroundView, textField])
        
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        backgroundView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}
