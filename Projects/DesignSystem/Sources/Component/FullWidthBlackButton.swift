//
//  FullWidthBlackButton.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/20.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

/// 가로를 꽉 채우는 형태의 검은색 UIButton
/// - override func setTitle: 버튼의 타이틀을 NSAttributeString으로 set 해줍니다.
///
/// 높이는 55 point로 정해져 있습니다.
/// 좌,우 constarints 와 Y축을 지정해주면 됩니다.
public final class FullWidthBlackButton: UIButton {
    
    public init() {
        super.init(frame: .zero)
        configureUI()
        createLayout()
    }
    
    public init(state: Bool) {
        super.init(frame: .zero)
        configureUI()
        createLayout()
        setButtonState(state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        guard let title = title else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedString, for: state)
    }
    
    public func setButtonState(_ state: Bool) {
        isEnabled = state
        backgroundColor = state ? .black : .zestyColor(.disabled)
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
