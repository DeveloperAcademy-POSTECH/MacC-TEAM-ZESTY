//
//  ProfileLinkView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/27.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class ProfileLinkButtonView: UIView {
    
    // MARK: Properties
        
    private let instaButton = UIButton()
    private let mailButton = UIButton()
//    private let instaLabel = UILabel()
//    private let mailLabel = UILabel()
    
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

extension ProfileLinkButtonView {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .zestyColor(.background)

        instaButton.setImage(UIImage(.btn_link_instargram), for: .normal)
        
//        instaLabel.text = "인스타"
//        instaLabel.textColor = .black
//        instaLabel.font = .systemFont(ofSize: 13, weight: .regular)
//        instaLabel.textAlignment = .center
//        instaLabel.numberOfLines = 1

        mailButton.setImage(UIImage(.btn_link_mail), for: .normal)

//        mailLabel.text = "문의"
//        mailLabel.textColor = .black
//        mailLabel.font = .systemFont(ofSize: 13, weight: .regular)
//        mailLabel.textAlignment = .center
//        mailLabel.numberOfLines = 1
    }
    
    private func createLayout() {
        addSubviews([instaButton, mailButton])
        
        instaButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalTo(mailButton.snp.leading).offset(-40)
            make.leading.equalToSuperview()
            make.width.equalTo(60)
        }

        mailButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(instaButton.snp.centerY)
        }
        
    }
     
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ProfileLinkViewPreview: PreviewProvider {

    static var previews: some View {
        ProfileLinkButtonView().toPreview()
    }

}
#endif
