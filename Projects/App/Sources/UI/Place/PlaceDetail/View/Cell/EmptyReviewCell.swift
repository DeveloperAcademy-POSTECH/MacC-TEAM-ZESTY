//
//  EmptyReviewCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit
import Kingfisher

class EmptyReviewCell: UITableViewCell {

    // MARK: - Properties

    private let bgView: UIView = {
        $0.backgroundColor = .zestyColor(.grayF6)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        return $0
    }(UIView())
    
    private let emojiView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(.img_reviewfriends_together)
        return $0
    }(UIImageView(frame: .zero))
    
    private let descriptionLabel: UILabel = {
        $0.text = "아직 사진리뷰가 없어요"
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .zestyColor(.dim)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        createLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Function
        
}

    // MARK: - UI Function

extension EmptyReviewCell {
    
    private func configureUI() {
        self.backgroundColor = .zestyColor(.background)
    }
    
    private func createLayout() {
        contentView.addSubviews([bgView, emojiView, descriptionLabel])
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(UIScreen.main.isWiderThan425pt ? 365 : 330)
        }
        
        bgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.isWiderThan425pt ? 330 : 300)
        }
        
        emojiView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-5)
            $0.width.height.equalTo(50)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emojiView.snp.bottom).offset(4)
        }
          
    }
}
