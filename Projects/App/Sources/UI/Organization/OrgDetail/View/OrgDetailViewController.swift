//
//  OrgDetailView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class OrgDetailViewController: UIViewController {

    // MARK: - Properties

    private let inviteButton = UIButton()
    private let orgName = UILabel()
    private let orgUsers = UILabel()
    private let orgPlace = UILabel()
    private let orgPlacePhoto = UILabel()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }

    // MARK: - Function

}

// MARK: - UI Function

extension OrgDetailViewController {
    
    private func configureUI() {
        view.backgroundColor = .zestyColor(.background)
        
        orgName.text = "킹밥는대학교"
        orgName.textColor = .black
        orgName.font = UIFont.systemFont(ofSize: CGFloat(26), weight: .bold)
        
        orgUsers.text = "218명의 Zesters"
        orgUsers.textColor = .black
        orgUsers.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .medium)
        orgUsers.textAlignment = .center
        
        inviteButton.configuration = .filled()
        inviteButton.tintColor = .black
        inviteButton.setTitle("우리학교 사람들 초대하기", for: .normal)
        inviteButton.configuration?.buttonSize = .large
    }

    private func createLayout() {
        view.addSubview(orgName)
        view.addSubview(orgUsers)
        view.addSubview(inviteButton)

        orgName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(50)
        }
        
        orgUsers.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        inviteButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(300)
        }
    }

}
