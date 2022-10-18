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
        addSubviews([orgNameLabel, disclosureIndicator])
        
        selectionStyle = .none
        
        disclosureIndicator.image = UIImage(systemName: "chevron.right")
        disclosureIndicator.tintColor = .black
        
        orgNameLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func createLayout() {
        orgNameLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).inset(20)
            make.verticalEdges.equalToSuperview().inset(16)
        }
        
        disclosureIndicator.snp.makeConstraints { make in
            make.right.equalTo(snp.right).inset(20)
            make.verticalEdges.equalToSuperview().inset(16)
        }
    }
    
}
