//
//  ReviewCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import DesignSystem
import UIKit
import SnapKit
import Kingfisher

final class ReviewCell: UITableViewCell {

    // MARK: - Properties

    private let cardView = UIView()
    
    private let reviewImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    private let emojiView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(.img_reviewfriends_good)
        return $0
    }(UIImageView(frame: .zero))
    
    private let menuLabel: UILabel = {
        $0.font = .systemFont(ofSize: 20, weight: .black)
        $0.textColor = .staticLabel
        $0.textAlignment = .left
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .staticSecondaryLabel
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        emojiView.showAnimation {
            // 추후 클릭이벤트 생성시 작성
        }
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
    func setup(with review: Review) {
        DispatchQueue.main.async {
            
            self.reviewImageView.kf.setImage(with: review.imageURL)
            self.menuLabel.text = review.menuName
            self.dateLabel.text = review.createdAt.formatted("yyyy.MM.dd")

            switch review.evaluation {
            case .good:
                self.emojiView.image = UIImage(.img_reviewfriends_good)
            case .soso:
                self.emojiView.image = UIImage(.img_reviewfriends_soso)
            case .bad:
                self.emojiView.image = UIImage(.img_reviewfriends_bad)
            }
        }
    }
        
}

    // MARK: - UI Function

extension ReviewCell {
    
    private func configureUI() {
        self.backgroundColor = .background
        self.cardView.layer.applyFigmaShadow()
    }
    
    private func createLayout() {
         contentView.addSubviews([reviewImageView, emojiView, menuLabel, dateLabel])
         
         contentView.snp.makeConstraints {
             $0.centerX.equalToSuperview()
             $0.width.equalToSuperview()
             $0.height.equalTo(UIScreen.main.isWiderThan425pt ? 365 : 330)
         }
         
         reviewImageView.snp.makeConstraints {
             $0.center.equalToSuperview()
             $0.width.height.equalTo(UIScreen.main.isWiderThan425pt ? 330 : 300)
         }
         
         self.setImageViewBackgroundGradient()
        
        reviewImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.isWiderThan425pt ? 330 : 300)
        }
        
        emojiView.snp.makeConstraints {
            $0.top.equalTo(reviewImageView.snp.top).inset(20)
            $0.trailing.equalTo(reviewImageView.snp.trailing).inset(20)
            $0.width.height.equalTo(60)
        }
        
        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewImageView.snp.leading).inset(20)
            $0.trailing.equalTo(reviewImageView.snp.trailing).inset(20)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-5)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewImageView.snp.leading).inset(20)
            $0.trailing.equalTo(reviewImageView.snp.trailing).inset(20)
            $0.bottom.equalTo(reviewImageView.snp.bottom).inset(20)
        }
          
    }
      
    private func setImageViewBackgroundGradient() {
        self.layoutIfNeeded()
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.locations = [0.0, 1.0]
        let colors: [CGColor] = [
            UIColor.clear.cgColor,
            UIColor.mainListDescription.cgColor
        ]
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.71)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = .init(x: 0, y: 0,
                               width: self.reviewImageView.frame.width,
                               height: self.reviewImageView.frame.height)
        self.reviewImageView.layer.insertSublayer(gradient, at: 0)
    }

}
