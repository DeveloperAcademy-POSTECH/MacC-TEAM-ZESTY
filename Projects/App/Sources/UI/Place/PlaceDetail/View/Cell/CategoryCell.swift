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
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCell {
    
    // MARK: UI Function
    
    func configureUI() {
        contentView.backgroundColor = .white
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 14
    }
    
    func createLayout() {
        contentView.addSubviews([nameLabel])
        
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
