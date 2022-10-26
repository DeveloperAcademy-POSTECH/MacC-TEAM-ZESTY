//
//  ProfileNickNameView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class ProfileNickNameView: UIView {

    // MARK: - Properties
    
    private let changeNickNameButton = UIButton()
    private let nickName = UILabel()

    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Function

}

// MARK: - UI Function
extension ProfileNickNameView {

    private func configureUI() {
        backgroundColor = .zestyColor(.background)
        
        changeNickNameButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        changeNickNameButton.tintColor = .black

        nickName.text = "6글자제한O"
        nickName.textColor = .black
        nickName.font = UIFont.systemFont(ofSize: CGFloat(22), weight: .bold)
        nickName.textAlignment = .center
        nickName.numberOfLines = 1
    }

    private func createLayout() {
        addSubviews([changeNickNameButton, nickName])

        snp.makeConstraints { make in
            make.height.equalTo(28)
        }

        changeNickNameButton.snp.makeConstraints { make in
            make.leading.equalTo(nickName.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }

        nickName.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct OrgDetailCellPreview: PreviewProvider {

    static var previews: some View {
        ProfileNickNameView().toPreview()
    }

}
#endif
