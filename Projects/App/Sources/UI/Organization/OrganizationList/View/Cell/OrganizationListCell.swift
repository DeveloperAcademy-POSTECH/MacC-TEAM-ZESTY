//
//  OrgListCell.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class OrganizationListCell: UITableViewCell {
    
    // MARK: Properties
    
    private var cancelBag = Set<AnyCancellable>()
    private var organization: Organization?
    
    static let identifier = "OrgListCell"
    
    private let orgNameLabel = UILabel()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelBag.removeAll()
    }
    
    func bind(with organization: Organization) {
        orgNameLabel.text = organization.name
    }
}

// MARK: UI Function

extension OrganizationListCell {
    
    private func configureUI() {
        addSubviews([orgNameLabel, disclosureIndicator])
        
        selectionStyle = .none
        
        disclosureIndicator.image = UIImage(systemName: "chevron.right")
        disclosureIndicator.tintColor = .label
        
        orgNameLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func createLayout() {
        orgNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(16)
        }
        
        disclosureIndicator.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(16)
        }
    }
    
}
