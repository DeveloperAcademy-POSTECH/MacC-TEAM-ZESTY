//
//  OrgListCell.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

class OrgListCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "OrgListCell"
    
    let orgNameLabel = UILabel()
    
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

extension OrgListCell {
    
    // MARK: UI Function
    
    private func configureUI() {
        self.addSubview(orgNameLabel)
        
        orgNameLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func createLayout() {
        orgNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        orgNameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
        
    }
}
