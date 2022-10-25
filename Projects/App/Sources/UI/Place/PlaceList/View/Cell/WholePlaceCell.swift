//
//  WholePlaceCell.swift
//  App
//
//  Created by 리아 on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class WholePlaceCell: UITableViewCell {
    // TODO: 리뷰가 없는 상황을 가정한 cell입니다. 변경 예정
    private let viewModel = PlaceCellVeiwModel(placeName: "쌀국수 집을 하려다가 망한\n소바집인데 쌀국수가 잘팔리는 곳", category: Category(id: 2, name: "일식"), goodCount: 17, sosoCount: 2, badCount: 4, menuName: nil, reviewImage: nil)
    
    // MARK: - Properties
    private let horizontalPadding: CGFloat = 45
    private lazy var screenWidth = UIScreen.main.bounds.size.width

    static let identifier = "WholePlaceCell"
    
    private lazy var mainStackView = UIStackView()
    
    private lazy var reviewImageView = UIImageView()
    
    private lazy var middelView = UIView()
    private lazy var gradientStackView = UIStackView()
    private lazy var gradientView = GradientView(gradientStartColor: .clear, gradientEndColor: .black)
    private lazy var menuLabel = UILabel()
    
    private lazy var bottomView = UIView()
    
    private lazy var placeNameLabel = UILabel()
    
    private lazy var emojiStackView = UIStackView()
    
    private lazy var goodEmojiStackView = EmojiCountStackView(emojiCount: viewModel.goodCount, emoji: UIImage(.img_reviewfriends_good_30)!)
    private lazy var sosoEmojiStackView = EmojiCountStackView(emojiCount: viewModel.sosoCount, emoji: UIImage(.img_reviewfriends_soso_30)!)
    private lazy var badEmojiStackView = EmojiCountStackView(emojiCount: viewModel.badCount, emoji: UIImage(.img_reviewfriends_bad_30)!)
    
    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - UI Function

extension WholePlaceCell {
    
    func configureUI() {
        configureGradientView()
        
        mainStackView.spacing = 0
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.layer.cornerRadius = 16
        mainStackView.layer.masksToBounds = true
        
        if !viewModel.isReviewExists {
            mainStackView.layer.borderWidth = 1
        }
        
        reviewImageView.image = viewModel.reviewImage
        reviewImageView.contentMode = .scaleAspectFit
        
        menuLabel.text = viewModel.menuName
        menuLabel.textColor = .white
        
        bottomView.backgroundColor = .label
        
        placeNameLabel.textColor = .zestyColor(.whiteEBEBF5)
        placeNameLabel.text = viewModel.placeName
        placeNameLabel.numberOfLines = 2
        placeNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        emojiStackView.spacing = 12
        emojiStackView.axis = .horizontal
        emojiStackView.distribution = .fill
    }
    
    private func createLayout() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubviews([reviewImageView, middelView, bottomView])
        middelView.addSubviews([gradientView, menuLabel])
        bottomView.addSubviews([placeNameLabel, emojiStackView])
        
        emojiStackView.addArrangedSubviews([goodEmojiStackView, sosoEmojiStackView, badEmojiStackView])
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(horizontalPadding)
            make.bottom.equalToSuperview().inset(20)
        }
        
        reviewImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(screenWidth - horizontalPadding * 2)
        }
        
        middelView.snp.makeConstraints { make in
            make.top.equalTo(reviewImageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.greaterThanOrEqualTo(58)
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        menuLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(middelView.snp.bottom)
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
        WholePlaceCell().toPreview()
    }
    
}
#endif
