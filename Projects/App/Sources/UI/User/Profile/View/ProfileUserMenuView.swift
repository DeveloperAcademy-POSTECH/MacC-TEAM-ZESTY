//
//  ProfileUserMenuView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class ProfileUserMenuView: UIView {
    
    // MARK: Properties
        
    private let userMenuLabel = UILabel()
    private let isSE = UIScreen.main.isHeightLessThan670pt
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }
    
    convenience init(userMenuText: String) {
        self.init(frame: .zero)
        userMenuLabel.text = userMenuText
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
        userMenuLabel.textColor = .zestyColor(.dim)
        userMenuLabel.textAlignment = .left
        userMenuLabel.numberOfLines = 1
    }
    
    private func createLayout() {
        addSubview(userMenuLabel)
        
        if isSE {
            snp.makeConstraints {
                $0.height.equalTo(50)
            }
        } else {
            snp.makeConstraints {
                $0.height.equalTo(60)
            }
        }
        
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
