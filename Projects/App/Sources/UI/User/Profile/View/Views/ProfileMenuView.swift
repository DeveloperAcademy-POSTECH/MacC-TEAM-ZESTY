//
//  ProfileMenuView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileMenuView: UIView {
    
    // MARK: Properties
        
    private let menuLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let isSE = UIScreen.main.isHeightLessThan670pt
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }
    
    convenience init(menuText: String) {
        self.init(frame: .zero)
        menuLabel.text = menuText
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension ProfileMenuView {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .clear

        menuLabel.font = .systemFont(ofSize: 16, weight: .medium)
        menuLabel.textColor = .label
        menuLabel.textAlignment = .left
        menuLabel.numberOfLines = 1
        
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .label
    }
    
    private func createLayout() {
        addSubviews([menuLabel, chevronImageView])
        
        if isSE {
            snp.makeConstraints {
                $0.height.equalTo(50)
            }
        } else {
            snp.makeConstraints {
                $0.height.equalTo(60)
            }
        }
        
        menuLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(menuLabel.snp.centerY)
            make.leading.equalTo(menuLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(12)
        }
    }
     
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ProfileMenuViewPreview: PreviewProvider {

    static var previews: some View {
        ProfileMenuView().toPreview()
    }

}
#endif
