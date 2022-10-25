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

    private let inviteButton = FullWidthBlackButton()
    private let orgName = UILabel()
    
    private var orgDetailCell1 = OrgDetailCell()
    private var orgDetailCell2 = OrgDetailCell()
    private var orgDetailCell3 = OrgDetailCell()

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
        
        orgName.text = "경상국립대학교 칠암캠퍼스(경남과기대)"
        orgName.textColor = .black
        orgName.font = UIFont.systemFont(ofSize: CGFloat(26), weight: .bold)
        orgName.textAlignment = .center
        orgName.numberOfLines = 2
        
        orgDetailCell1 = OrgDetailCell()
        orgDetailCell2 = OrgDetailCell()
        orgDetailCell3 = OrgDetailCell()
        
        inviteButton.setTitle("우리학교 사람들 초대하기", for: .normal)
    }

    private func createLayout() {
        view.addSubview(orgName)
        view.addSubview(orgDetailCell1)
        view.addSubview(orgDetailCell2)
        view.addSubview(orgDetailCell3)
        view.addSubview(inviteButton)

        orgName.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        orgDetailCell1.snp.makeConstraints { make in
            make.top.equalTo(orgName.snp.bottom).offset(60)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(20)
            
        }
        
        orgDetailCell2.snp.makeConstraints { make in
            make.top.equalTo(orgDetailCell1.snp.bottom).offset(60)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(20)
        }
        
        orgDetailCell3.snp.makeConstraints { make in
            make.top.equalTo(orgDetailCell2.snp.bottom).offset(60)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(20)
        }

        inviteButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
