//
//  OrgDetailView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class OrgDetailViewController: UIViewController {

    // MARK: - Properties

    private let orgNameLabel = UILabel()
    private let orgInformationSuperStackView = UIStackView()
    private let orgInformationStackView1 = UIStackView()
    private let orgInformationStackView2 = UIStackView()
    private let orgInformationStackView3 = UIStackView()
    private let orgInformationImage1 = UIImageView()
    private let orgInformationImage2 = UIImageView()
    private let orgInformationImage3 = UIImageView()
    private let orgInviteButton = FullWidthBlackButton()

    private var orgDetailInformationView1 = OrgDetailInformationView()
    private var orgDetailInformationView2 = OrgDetailInformationView()
    private var orgDetailInformationView3 = OrgDetailInformationView()

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
        
        orgDetailInformationView1 = OrgDetailInformationView()
        orgDetailInformationView2 = OrgDetailInformationView()
        orgDetailInformationView3 = OrgDetailInformationView()
        
        orgNameLabel.text = "애플 디벨로퍼 아카데미"
        orgNameLabel.textColor = .black
        orgNameLabel.font = UIFont.systemFont(ofSize: CGFloat(26), weight: .bold)
        orgNameLabel.textAlignment = .center
        orgNameLabel.numberOfLines = 2
        
        orgInformationSuperStackView.axis = .vertical
        orgInformationSuperStackView.alignment = .leading
        orgInformationSuperStackView.distribution = . fillProportionally
        orgInformationSuperStackView.spacing = 50
        
        orgInformationStackView1.axis = .horizontal
        orgInformationStackView1.alignment = .center
        orgInformationStackView1.distribution = .fillEqually
        orgInformationStackView1.spacing = 30
        
        orgInformationStackView2.axis = .horizontal
        orgInformationStackView2.alignment = .center
        orgInformationStackView2.distribution = .fillEqually
        orgInformationStackView2.spacing = 30

        orgInformationStackView3.axis = .horizontal
        orgInformationStackView3.alignment = .center
        orgInformationStackView3.distribution = .fillEqually
        orgInformationStackView3.spacing = 30

        orgInformationImage1.image = UIImage(.img_reviewfriends_together)
        orgInformationImage1.contentMode = .scaleAspectFit
        orgInformationImage1.layer.applyFigmaShadow(color: .black, opacity: 0.1, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        orgDetailInformationView1.informationLabel.text = "함께하는 친구들"
        orgDetailInformationView1.numberLabel.text = "13,966명"
        
        orgInformationImage2.image = UIImage(.img_categoryfriends_western)
        orgInformationImage2.contentMode = .scaleAspectFit
        orgDetailInformationView2.informationLabel.text = "등록된 맛집"
        orgDetailInformationView2.numberLabel.text = "1,425곳"
        
        orgInformationImage3.image = UIImage(.img_reviewfriends_photo)
        orgInformationImage3.contentMode = .scaleAspectFit
        orgInformationImage3.layer.applyFigmaShadow(color: .black, opacity: 0.1, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        orgDetailInformationView3.informationLabel.text = "업로드된 사진"
        orgDetailInformationView3.numberLabel.text = "124,513개"
        
        orgInviteButton.setTitle("우리학교 사람들 초대하기", for: .normal)
    }

    private func createLayout() {
        view.addSubviews([orgNameLabel, orgInformationSuperStackView, orgInformationStackView1, orgInformationStackView2, orgInformationStackView3, orgInviteButton])
        orgInformationSuperStackView.addArrangedSubviews([orgInformationStackView1, orgInformationStackView2, orgInformationStackView3])
        orgInformationStackView1.addArrangedSubviews([orgInformationImage1, orgDetailInformationView1])
        orgInformationStackView2.addArrangedSubviews([orgInformationImage2, orgDetailInformationView2])
        orgInformationStackView3.addArrangedSubviews([orgInformationImage3, orgDetailInformationView3])

        orgNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(31)
        }
        
        orgInformationSuperStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(173)
            make.top.equalTo(orgNameLabel.snp.bottom).offset(50)
        }
        
        orgInformationStackView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        orgInformationStackView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        orgInformationStackView3.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }

        orgInviteButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
