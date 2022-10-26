//
//  ProfileMenuCell.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileMenuCell: UITableViewCell {
    
    // MARK: Properties
    
    private let menuLabel = UILabel()
    private let disclosureIndicator = UIImageView()
    
    // MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileMenuCell {
    
    // MARK: UI Function
    
    private func configureUI() {
        backgroundColor = .zestyColor(.background)
        
        selectionStyle = .none
        
        menuLabel.text = "공지사항"
        menuLabel.font = .systemFont(ofSize: 16, weight: .medium)
        menuLabel.textColor = .black
        menuLabel.textAlignment = .left
        menuLabel.numberOfLines = 1
        
        disclosureIndicator.image = UIImage(systemName: "chevron.right")
        disclosureIndicator.tintColor = .black
    }
    
    private func createLayout() {
        addSubviews([menuLabel, disclosureIndicator])
        
        snp.makeConstraints { make in
            make.height.equalTo(61)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(30)
            make.width.equalTo(308)
        }
        
        disclosureIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(menuLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
            make.leading.equalTo(menuLabel.snp.trailing).offset(10)
        }
    }
     
}
