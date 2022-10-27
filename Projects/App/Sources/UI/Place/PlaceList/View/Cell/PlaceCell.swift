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
    
    static let identifier = "PlaceCell"
     
    private lazy var containerView = UIView()
    private lazy var reviewView = ReviewPageView()
    private lazy var middelView = UIView()
    private lazy var gradientStackView = UIStackView()
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
        setUp(with: Place.mockData[0])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI Function

extension PlaceCell {

    func setUp(with place: Place) {
        placeNameLabel.text = place.name
        goodEmojiStackView.setUp(count: place.evaluationSum.good)
        sosoEmojiStackView.setUp(count: place.evaluationSum.soso)
        badEmojiStackView.setUp(count: place.evaluationSum.bad)
        
        place.reviews.forEach { review in
            reviewView.setUp(with: review)
        }
    }

    private func configureUI() {
        containerView.layer.applyFigmaShadow()
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true

        bottomView.backgroundColor = .label
        
        placeNameLabel.textColor = .white
        placeNameLabel.numberOfLines = 2
        placeNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        emojiStackView.spacing = 15
        emojiStackView.axis = .horizontal
        emojiStackView.distribution = .fillEqually
    }
    
    private func createLayout() {
        contentView.addSubview(containerView)
        containerView.addSubviews([reviewView, bottomView])
        bottomView.addSubviews([placeNameLabel, emojiStackView])
        emojiStackView.addArrangedSubviews([goodEmojiStackView, sosoEmojiStackView, badEmojiStackView])

        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.top.height.equalToSuperview().inset(15)
        }
        
        reviewView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(reviewView.snp.width)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(reviewView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emojiStackView.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
    }
    
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct PlaceCellPreview: PreviewProvider {
    
    static var previews: some View {
        PlaceCell().toPreview()
            .frame(width: 400, height: 450)
    }
    
}
#endif
