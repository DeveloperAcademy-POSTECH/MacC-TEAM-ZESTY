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

    let orgName = UILabel()
    let superStackView = UIStackView()
    let informationStackView1 = UIStackView()
    let informationStackView2 = UIStackView()
    let informationStackView3 = UIStackView()

    private let inviteButton = FullWidthBlackButton()
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
        
        superStackView.axis = .vertical
        superStackView.alignment = .top
        superStackView.distribution = . fillProportionally
        superStackView.spacing = 50
        
        informationStackView1.axis = .horizontal
        informationStackView1.alignment = .center
        informationStackView1.distribution = .fillEqually
        informationStackView1.spacing = 30
        
        informationStackView2.axis = .horizontal
        informationStackView2.alignment = .center
        informationStackView2.distribution = .fillEqually
        informationStackView2.spacing = 30

        informationStackView3.axis = .horizontal
        informationStackView3.alignment = .center
        informationStackView3.distribution = .fillEqually
        informationStackView3.spacing = 30

        logoImage1.image = UIImage(.img_reviewfriends_together)
        logoImage1.contentMode = .scaleAspectFit
        orgDetailCell1.informationLabel.text = "함께하는 친구들"
        orgDetailCell1.numberLabel.text = "13,966명"
        
        logoImage2.image = UIImage(.img_categoryfriends_western)
        logoImage2.contentMode = .scaleAspectFit
        orgDetailCell2.informationLabel.text = "등록된 맛집"
        orgDetailCell2.numberLabel.text = "1,425곳"
        
        logoImage3.image = UIImage(.img_reviewfriends_photo)
        logoImage3.contentMode = .scaleAspectFit
        logoImage3.layer.applyFigmaShadow(color: .black, opacity: 0.05, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        orgDetailCell3.informationLabel.text = "업로드된 사진"
        orgDetailCell3.numberLabel.text = "124,513개"
        
        inviteButton.setTitle("우리학교 사람들 초대하기", for: .normal)
    }

    private func createLayout() {
        view.addSubviews([orgName, superStackView, informationStackView1, informationStackView2, informationStackView3, inviteButton])
        superStackView.addArrangedSubviews([informationStackView1, informationStackView2, informationStackView3])
        informationStackView1.addArrangedSubviews([logoImage1, orgDetailCell1])
        informationStackView2.addArrangedSubviews([logoImage2, orgDetailCell2])
        informationStackView3.addArrangedSubviews([logoImage3, orgDetailCell3])

        orgName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
//            make.leading.trailing.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(31)
        }
        
        superStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(173)
            make.top.equalTo(orgName.snp.bottom).offset(50)
//            make.bottom.equalTo(inviteButton.snp.top).offset(-253)
        }
        
        informationStackView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        informationStackView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        informationStackView3.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }

        inviteButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
