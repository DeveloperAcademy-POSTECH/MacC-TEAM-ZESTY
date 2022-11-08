//
//  ProfileNickNameView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit
import Combine

final class ProfileNickNameView: UIView {

    // MARK: - Properties
    
    weak var viewModel: ProfileViewModel?
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let changeNickNameButton = UIButton()
    let nickNameLabel = UILabel()

    // MARK: - LifeCycle
    
    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureUI()
        createLayout()
        bindUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Function
    
    @objc private func changeNickNameButtonClicked() {
        viewModel?.changeNickNameButtonClicked.send(true)
    }
    
}

// MARK: - Bind UI
extension ProfileNickNameView {
    
    private func bindUI() {
        viewModel?.isNickNameChangedSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.nickNameLabel.text = UserInfoManager.userInfo?.userNickname
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function
extension ProfileNickNameView {

    private func configureUI() {
        backgroundColor = .zestyColor(.background)
        
        changeNickNameButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        changeNickNameButton.tintColor = .black
        changeNickNameButton.backgroundColor = .zestyColor(.background)
        changeNickNameButton.addTarget(self, action: #selector(changeNickNameButtonClicked), for: .touchUpInside)

        nickNameLabel.backgroundColor = .zestyColor(.background)
        nickNameLabel.textColor = .black
        nickNameLabel.font = UIFont.systemFont(ofSize: CGFloat(22), weight: .bold)
        nickNameLabel.text = viewModel?.userNickname
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
/*
#if DEBUG
import SwiftUI

struct ProfileNickNameViewPreview: PreviewProvider {

    static var previews: some View {
        ProfileNickNameView().toPreview()
    }

}
#endif
*/
