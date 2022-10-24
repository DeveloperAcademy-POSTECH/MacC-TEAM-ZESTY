//
//  CategoryIconCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit
import DesignSystem

final class CategoryIconCell: UICollectionViewCell {
    
    var viewModel: Category?
    
    private let cellView = UIView()
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        return $0
    }(UILabel())
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.1) {
                    self.contentView.backgroundColor = .black
                    self.nameLabel.textColor = .white
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.contentView.backgroundColor = .white
                    self.nameLabel.textColor = .black
                }
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubviews([imageView, nameLabel])
            
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.isWiderThan425pt ? 25 : 15 )
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.isLessThan376pt ? 50 : 65)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func configure(with viewModel: Category) {
        self.viewModel = viewModel
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.nameLabel.text = viewModel.name
        self.imageView.kf.setImage(with: URL(string: viewModel.imageURL ?? "https://user-images.githubusercontent.com/63157395/197410857-e13c1bbb-b19a-4c59-a493-77501a4a529b.png"))
    }

}
