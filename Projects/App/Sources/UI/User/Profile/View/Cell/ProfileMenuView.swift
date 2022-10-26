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
        
    let menuLabel = UILabel()
    private let chevronIndicator = UIImageView()
    
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

extension ProfileMenuView {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .zestyColor(.background)

        menuLabel.font = .systemFont(ofSize: 16, weight: .medium)
        menuLabel.textColor = .black
        menuLabel.textAlignment = .left
        menuLabel.numberOfLines = 1
        
        chevronIndicator.image = UIImage(systemName: "chevron.right")
        chevronIndicator.tintColor = .black
    }
    
    private func createLayout() {
        addSubviews([menuLabel, chevronIndicator])
        
        snp.makeConstraints { make in
            make.height.equalTo(61)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(30)
            make.width.equalTo(308)
        }
        
        chevronIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(menuLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
            make.leading.equalTo(menuLabel.snp.trailing).offset(10)
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
