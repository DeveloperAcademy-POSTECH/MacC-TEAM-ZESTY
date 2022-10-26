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
    private let viewModel = PlaceCellVeiwModel(placeName: "쌀국수 집을 하려다가 망한\n소바집인데 쌀국수가 잘팔리는 곳", category: Category(id: 2, name: "일식", imageURL: nil), goodCount: 17, sosoCount: 2, badCount: 4, menuName: "쌀국수", reviewImage: UIImage(.img_reviewfriends_together))
    
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
    
    lazy var goodEmojiStackView = EmojiCountStackView(emojiCount: viewModel.goodCount, emoji: UIImage(.img_reviewfriends_good_30)!)
    lazy var sosoEmojiStackView = EmojiCountStackView(emojiCount: viewModel.sosoCount, emoji: UIImage(.img_reviewfriends_soso_30)!)
    lazy var badEmojiStackView = EmojiCountStackView(emojiCount: viewModel.badCount, emoji: UIImage(.img_reviewfriends_bad_30)!)
    
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
    
    func configureUI() {
        configureGradientView()
        
        mainView.layer.cornerRadius = 16
        mainView.layer.masksToBounds = true
        
        reviewImageView.image = viewModel.reviewImage
        reviewImageView.contentMode = .scaleAspectFill
        
        gradientView.isHidden = viewModel.menuName!.isEmpty ? true : false
        
        menuLabel.text = viewModel.menuName
        menuLabel.textColor = .white
        
        bottomView.backgroundColor = .label
        
        placeNameLabel.textColor = .white
        placeNameLabel.text = viewModel.placeName
        placeNameLabel.numberOfLines = 2
        placeNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        emojiStackView.spacing = 15
        emojiStackView.axis = .horizontal
        emojiStackView.distribution = .fill
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
