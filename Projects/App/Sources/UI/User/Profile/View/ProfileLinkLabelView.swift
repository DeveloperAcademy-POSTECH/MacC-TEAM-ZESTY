//
//  ProfileLinkLabelView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/27.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class ProfileLinkLabelView: UIView {
    
    // MARK: Properties
        
    private let instaLabel = UILabel()
    private let mailLabel = UILabel()
    
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

extension ProfileLinkLabelView {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .zestyColor(.background)
        
        instaLabel.text = "인스타"
        instaLabel.textColor = .black
        instaLabel.font = .systemFont(ofSize: 13, weight: .regular)
        instaLabel.textAlignment = .center
        instaLabel.numberOfLines = 1

        mailLabel.text = "문의"
        mailLabel.textColor = .black
        mailLabel.font = .systemFont(ofSize: 13, weight: .regular)
        mailLabel.textAlignment = .center
        mailLabel.numberOfLines = 1
    }
    
    private func createLayout() {
        addSubviews([instaLabel, mailLabel])

        instaLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(mailLabel.snp.leading).offset(-70)
        }

        mailLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
     
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ProfileLinkLabelViewPreview: PreviewProvider {

    static var previews: some View {
        ProfileLinkLabelView().toPreview()
    }

}
#endif
