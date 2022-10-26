//
//  ProfileUserMenuView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileUserMenuView: UIView {
    
    // MARK: Properties
        
    let userMenuLabel = UILabel()
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension ProfileUserMenuView {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .zestyColor(.background)

        userMenuLabel.font = .systemFont(ofSize: 16, weight: .medium)
        userMenuLabel.textColor = .black
        userMenuLabel.textAlignment = .left
        userMenuLabel.numberOfLines = 1
    }
    
    private func createLayout() {
        addSubview(userMenuLabel)
        
        userMenuLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
    }
     
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ProfileUserMenuViewPreview: PreviewProvider {

    static var previews: some View {
        ProfileUserMenuView().toPreview()
    }

}
#endif
