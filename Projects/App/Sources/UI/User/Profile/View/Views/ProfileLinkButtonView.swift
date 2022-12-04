//
//  ProfileLinkView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/27.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import Firebase
import SnapKit

final class ProfileLinkButtonView: UIView {
    
    // MARK: Properties
        
    private let instaButton = UIButton()
    private let mailButton = UIButton()
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Function

    @objc func instaButtonDidTap() {
        instaButton.showAnimation {
            UrlUtils.openExternalLink(urlStr: "https://www.instagram.com/zesty__official/")
        }
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSelectItem, parameters: [
            AnalyticsParameterItemListName: "instagram_move"
        ])
    }
    
    @objc func mailButtonDidTap() {
        mailButton.showAnimation {
            UrlUtils.openExternalLink(urlStr: "https://docs.google.com/forms/d/e/1FAIpQLScONEq4_4S1A7upkeyf_mlW8dLY0OSPErUDpkJfahM83IfNBA/viewform")
        }
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSelectItem, parameters: [
            AnalyticsParameterItemListName: "google_forms_move"
        ])
    }
    
}

extension ProfileLinkButtonView {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .clear

        instaButton.setImage(UIImage(.btn_link_instargram), for: .normal)
        instaButton.addTarget(self, action: #selector(instaButtonDidTap), for: .touchUpInside)

        mailButton.setImage(UIImage(.btn_link_mail), for: .normal)
        mailButton.addTarget(self, action: #selector(mailButtonDidTap), for: .touchUpInside)
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
