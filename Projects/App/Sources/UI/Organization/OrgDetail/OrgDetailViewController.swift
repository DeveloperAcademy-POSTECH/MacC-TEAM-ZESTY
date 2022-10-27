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
    let orgName = UILabel()
    private let logoImage1 = UIImageView()
    private let logoImage2 = UIImageView()
    private let logoImage3 = UIImageView()
    
    private var orgDetailCell1 = OrgDetailInformationView()
    private var orgDetailCell2 = OrgDetailInformationView()
    private var orgDetailCell3 = OrgDetailInformationView()

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
        
        orgDetailCell1 = OrgDetailInformationView()
        orgDetailCell2 = OrgDetailInformationView()
        orgDetailCell3 = OrgDetailInformationView()
        
        orgName.text = "애플 디벨로퍼 아카데미"
        orgName.textColor = .black
        orgName.font = UIFont.systemFont(ofSize: CGFloat(26), weight: .bold)
        orgName.textAlignment = .center
        orgName.numberOfLines = 2
        
//        orgDetailCell1.logoImage.image = UIImage(.img_reviewfriends_together)
        orgDetailCell1.informationLabel.text = "함께하는 친구들"
        orgDetailCell1.numberLabel.text = "13.966명"
        logoImage1.image = UIImage(.img_reviewfriends_together)
        
        orgDetailCell2.informationLabel.text = "등록된 맛집"
        orgDetailCell2.numberLabel.text = "1,425곳"
        logoImage2.image = UIImage(.img_cate)
        
        orgDetailCell3.informationLabel.text = "업로드된 사진"
        orgDetailCell3.numberLabel.text = "124,513개"
        logoImage3.image = UIImage(.img_reviewfriends_together)
        
        
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
