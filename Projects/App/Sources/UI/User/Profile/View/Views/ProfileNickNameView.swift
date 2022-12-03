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
    
    private let changeNickNameImageView = UIImageView()
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
    
    @objc private func changeNickNameImageViewClicked() {
        viewModel?.changeNickNameImageViewClicked.send(true)
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
        backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeNickNameImageViewClicked))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
        
        changeNickNameImageView.image = UIImage(systemName: "pencil")
        changeNickNameImageView.contentMode = .scaleAspectFit
        changeNickNameImageView.tintColor = .label
        changeNickNameImageView.backgroundColor = .clear

        nickNameLabel.backgroundColor = .clear
        nickNameLabel.textColor = .label
        nickNameLabel.font = UIFont.systemFont(ofSize: CGFloat(22), weight: .bold)
        nickNameLabel.text = viewModel?.userNickname
    }

    private func createLayout() {
        addSubviews([changeNickNameImageView, nickNameLabel])

        snp.makeConstraints { make in
            make.height.equalTo(28)
        }

        changeNickNameImageView.snp.makeConstraints { make in
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
