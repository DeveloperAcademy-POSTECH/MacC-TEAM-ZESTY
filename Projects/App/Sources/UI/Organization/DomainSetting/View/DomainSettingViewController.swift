//
//  DomainSettingViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class DomainSettingViewController: UIViewController {

    // MARK: - Properties
    
    private let cancelBag = Set<AnyCancellable>()
    
    private let mainTitleView = MainTitleView(title: "학교 이메일을 알려주세요",
                                              subtitle: "학교 인증에 사용돼요.")
    private let domainInputBox = UIView()
    private let domainStackView = UIStackView()
    private let domainTextField = UITextField()
    private let domainPlaceholder = UILabel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension DomainSettingViewController {
    
    private func configureUI() {
        domainInputBox.backgroundColor = .black
        domainInputBox.layer.cornerRadius = 25
        domainInputBox.layer.masksToBounds = true
        
        domainStackView.spacing = 10
        domainStackView.axis = .horizontal
        domainStackView.distribution = .fill
        domainStackView.alignment = .fill
        
        domainTextField.attributedPlaceholder = .init(attributedString: NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        domainTextField.textColor = .white
        domainTextField.font = .systemFont(ofSize: 17, weight: .medium)
        
        domainPlaceholder.textColor = .white
        domainPlaceholder.text = "@pos.idserve.net"
        domainPlaceholder.font = .systemFont(ofSize: 17, weight: .medium)
        domainPlaceholder.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
    }
    
    private func createLayout() {
        view.addSubviews([mainTitleView, domainInputBox])
        
        domainInputBox.addSubview(domainStackView)
        domainStackView.addArrangedSubviews([domainTextField, domainPlaceholder])
        
        mainTitleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        domainInputBox.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(310)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        domainStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(14)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.width.lessThanOrEqualTo(270)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct DomainSettingViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        DomainSettingViewController().toPreview()
    }
    
}
#endif
