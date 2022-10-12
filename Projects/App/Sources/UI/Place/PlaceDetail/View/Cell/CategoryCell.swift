//
//  CategoryTagCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellID = "CategoryCell"
    
    lazy var nameLabel: UILabel = {
        $0.text = "카테고리"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCell {
    
    // MARK: UI Function
    
    func configureUI() {
        contentView.backgroundColor = .systemGray5
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
    }
    
    func configureLayout() {
        contentView.addSubviews([nameLabel])
        
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
