//
//  OrgListCell.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class OrganizationListCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "OrgListCell"
    
    let orgNameLabel = UILabel()
    private let disclosureIndicator = UIImageView()
    
    // MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrganizationListCell {
    
    // MARK: UI Function
    
    private func configureUI() {
        self.addSubviews([orgNameLabel, disclosureIndicator])
        
        self.selectionStyle = .none
        
        disclosureIndicator.image = UIImage(systemName: "chevron.right")
        disclosureIndicator.tintColor = .black
        
        orgNameLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func createLayout() {
        orgNameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(20)
            make.top.equalTo(self.snp.top).inset(16)
            make.bottom.equalTo(self.snp.bottom).inset(16)
        }
        
        disclosureIndicator.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
    }
}
