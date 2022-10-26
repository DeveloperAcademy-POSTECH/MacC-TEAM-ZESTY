//
//  PlaceCell.swift
//  App
//
//  Created by 리아 on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class PlaceCell: UITableViewCell {
    // TODO: 리뷰가 없는 상황을 가정한 cell입니다. 변경 예정
    
    // MARK: - Properties
    
    static let identifier = "WholePlaceCell"
    
    private lazy var mainView = UIView()
    
    private lazy var reviewImageView = UIImageView()
    
    private lazy var middelView = UIView()
    private lazy var gradientStackView = UIStackView()
    private lazy var gradientView = GradientView(gradientStartColor: .clear, gradientEndColor: .black)
    private lazy var menuLabel = UILabel()
    
    private lazy var bottomView = UIView()
    
    private lazy var placeNameLabel = UILabel()
    
    private lazy var emojiStackView = UIStackView()
    
    private lazy var goodEmojiStackView = EmojiCountStackView(type: .good)
    private lazy var sosoEmojiStackView = EmojiCountStackView(type: .soso)
    private lazy var badEmojiStackView = EmojiCountStackView(type: .bad)
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI Function

extension PlaceCell {
    
    func setUp(with place: Place) {
        mainView.layer.borderWidth = place.reviews[0].menuName!.isEmpty ? 1 : 0
        reviewImageView.load(url: place.reviews[0].imageURL)
        gradientView.isHidden = place.reviews[0].menuName!.isEmpty ? true : false
        menuLabel.text = place.reviews[0].menuName
        placeNameLabel.text = place.name
        goodEmojiStackView.setUp(count: place.evaluationSum.good)
        sosoEmojiStackView.setUp(count: place.evaluationSum.soso)
        badEmojiStackView.setUp(count: place.evaluationSum.bad)
    }
    
    private func configureUI() {
        configureGradientView()
        
        mainView.layer.applyFigmaShadow()
        mainView.layer.cornerRadius = 16
        mainView.layer.masksToBounds = true
        
        reviewImageView.contentMode = .scaleAspectFill

        menuLabel.textColor = .white
        
        bottomView.backgroundColor = .label

        placeNameLabel.textColor = .white
        placeNameLabel.numberOfLines = 2
        placeNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        emojiStackView.spacing = 15
        emojiStackView.axis = .horizontal
        emojiStackView.distribution = .fillEqually
    }
    
    private func createLayout() {
        contentView.addSubview(mainView)
        mainView.addSubviews([reviewImageView, gradientView, menuLabel, bottomView])
        bottomView.addSubviews([placeNameLabel, emojiStackView])
        
        emojiStackView.addArrangedSubviews([goodEmojiStackView, sosoEmojiStackView, badEmojiStackView])
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().inset(20)
        }
        
        reviewImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(reviewImageView.snp.width)
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(reviewImageView.snp.bottom)
            make.height.greaterThanOrEqualTo(58)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalTo(gradientView.snp.bottom)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(reviewImageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emojiStackView.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(130)
        }
    }
    
    private func configureGradientView() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
    }
    
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct WholePlaceCellPreview: PreviewProvider {
    
    static var previews: some View {
        PlaceCell().toPreview()
    }
    
}
#endif
