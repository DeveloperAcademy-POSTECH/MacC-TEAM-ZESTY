//
//  ProfileNickNameView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileNickNameView: UIView {

    // MARK: - Properties
    
    private let changeNickNameButton = UIButton()
    private let nickNameLabel = UILabel()

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
        changeNickNameButton.backgroundColor = .zestyColor(.background)

        nickNameLabel.text = "6글자제한O"
        nickNameLabel.backgroundColor = .zestyColor(.background)
        nickNameLabel.textColor = .black
        nickNameLabel.font = UIFont.systemFont(ofSize: CGFloat(22), weight: .bold)
    }

    private func createLayout() {
        addSubviews([changeNickNameButton, nickNameLabel])

        snp.makeConstraints { make in
            make.height.equalTo(28)
        }

        changeNickNameButton.snp.makeConstraints { make in
            make.leading.equalTo(nickNameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        nickNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}

// MARK: - Previews
#if DEBUG
import SwiftUI

struct ProfileNickNameViewPreview: PreviewProvider {

    static var previews: some View {
        ProfileNickNameView().toPreview()
    }

}
#endif
