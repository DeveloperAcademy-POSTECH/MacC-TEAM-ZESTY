//
//  ReviewCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

class ReviewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellID = "ReviewCell"
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.layer.borderWidth = 2
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var shadowView: UIView = {
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        return $0
    }(UIView())
    
    private let emojiView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(.img_good_circle)
        return $0
    }(UIImageView(frame: .zero))
    
    private let evalutationLabel: UILabel = {
        $0.font = .systemFont(ofSize: 11)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let menuLabel: UILabel = {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .zestyColor(.gray3C3C43)?.withAlphaComponent(0.6)
        $0.textAlignment = .left
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

extension ReviewCell {
    
    // MARK: UI Function
    
    func configureUI() {
        
    }
    
    func createLayout() {
        contentView.addSubviews([imageView, shadowView, emojiView, evalutationLabel, menuLabel, dateLabel])
        
        contentView.sendSubviewToBack(emojiView)
        contentView.sendSubviewToBack(shadowView)
        
        emojiView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(9)
            $0.width.height.equalTo(30)
        }
        evalutationLabel.snp.makeConstraints {
            $0.top.equalTo(emojiView.snp.top).offset(2)
            $0.leading.equalTo(emojiView.snp.trailing).offset(5)
        }
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(167)
        }
        shadowView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(167)
        }
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.bottom).offset(5)
        }

    }
}

extension ReviewCell {
    func setup(with review: Review) {
        imageView.image = UIImage(named: "test-pasta")
        menuLabel.text = review.menuName
        dateLabel.text = review.createdAt.formatted("yyyy/MM/dd")
          
        switch review.evaluation {
        case .good:
            evalutationLabel.text = "맛집"
            emojiView.image = UIImage(.img_good_circle)
        case .soso:
            evalutationLabel.text = "무난"
            emojiView.image = UIImage(.img_soso_circle)
        case .bad:
            evalutationLabel.text = "별로"
            emojiView.image = UIImage(.img_bad_circle)
        }
        
    }
}
