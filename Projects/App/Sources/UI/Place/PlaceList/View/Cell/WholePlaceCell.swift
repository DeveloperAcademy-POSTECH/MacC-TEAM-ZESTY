//
//  WholePlaceCell.swift
//  App
//
//  Created by 리아 on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import SnapKit

final class WholePlaceCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var nameLabel = UILabel()
    private lazy var categoryLabel = UILabel()
    private lazy var reviewStackView = UIStackView()
    private lazy var goodImageView = UIImageView()
    private lazy var sosoImageView = UIImageView()
    private lazy var badImageView = UIImageView()
    private lazy var goodLabel = UILabel()
    private lazy var sosoLabel = UILabel()
    private lazy var badLabel = UILabel()
    private lazy var review1View = ShadowView()
    private lazy var review2View = ShadowView()
    private lazy var review1Label = UILabel()
    private lazy var review2Label = UILabel()
    private lazy var shadowView = ShadowView()
    
    // TODO: ViewModel에 옮기기
    private let name = "요기쿠시동"
    private let category = "일식, 돈까스"
    private let good = "17"
    private let soso = "2"
    private let bad = "4"
    private let review1Menu = "야끼쿠시동 - 새우"
    private let review2Menu = "에그카츠헬"
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        nameLabel.text = name
        categoryLabel.text = category
        
        reviewStackView.axis = .horizontal
        reviewStackView.spacing = 2
        reviewStackView.distribution = .fillEqually
        let zesterImage =  UIImage(.img_zesterone)
        goodImageView.image = zesterImage
        goodImageView.contentMode = .scaleAspectFit
        sosoImageView.image = zesterImage
        sosoImageView.contentMode = .scaleAspectFit
        badImageView.image = zesterImage
        badImageView.contentMode = .scaleAspectFit
        goodLabel.text = good
        sosoLabel.text = soso
        badLabel.text = bad
        
        let image = UIImage(.img_zesterthree)
        let imageView1 = UIImageView(image: image)
        imageView1.backgroundColor = .orange
        imageView1.contentMode = .scaleAspectFit
        let imageView2 = UIImageView(image: image)
        imageView2.backgroundColor = .orange
        imageView2.contentMode = .scaleAspectFit
        review1View.addView(imageView1)
        review2View.addView(imageView2)
        review1Label.text = review1Menu
        review2Label.text = review2Menu
    }
    
    private func createLayout() {
        let defaultInset = 15
        reviewStackView.addArrangedSubviews([goodImageView, goodLabel,
                                             sosoImageView, sosoLabel,
                                             badImageView, badLabel])
        contentView.addSubviews([shadowView, nameLabel, categoryLabel,
                                 reviewStackView,
                                 review1View, review2View,
                                 review1Label, review2Label])
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(defaultInset)
            $0.height.greaterThanOrEqualTo(20)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(defaultInset)
            $0.height.greaterThanOrEqualTo(20)
        }
        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(defaultInset)
            $0.width.greaterThanOrEqualTo(10)
            $0.height.equalTo(30)
        }
        goodImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        sosoImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        badImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        review1View.snp.makeConstraints {
            $0.top.equalTo(reviewStackView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(defaultInset)
            $0.trailing.equalTo(contentView.snp.centerX).offset(-10)
            $0.height.equalTo(review1View.snp.width)
        }
        review2View.snp.makeConstraints {
            $0.top.equalTo(reviewStackView.snp.bottom).offset(5)
            $0.leading.equalTo(contentView.snp.centerX).offset(10)
            $0.trailing.equalToSuperview().inset(defaultInset)
            $0.height.equalTo(review2View.snp.width)
        }
        review1Label.snp.makeConstraints {
            $0.top.equalTo(review1View.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(defaultInset)
            $0.trailing.equalTo(review1View.snp.trailing)
            $0.height.greaterThanOrEqualTo(20)
            $0.bottom.equalToSuperview().inset(defaultInset)
        }
        review2Label.snp.makeConstraints {
            $0.top.equalTo(review2View.snp.bottom).offset(5)
            $0.leading.equalTo(review2View.snp.leading)
            $0.trailing.equalToSuperview().inset(defaultInset)
            $0.height.greaterThanOrEqualTo(20)
            $0.bottom.equalToSuperview().inset(defaultInset)
        }
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Preview

struct WholePlaceCellPreview: PreviewProvider {
    
    static var previews: some View {
        WholePlaceCell().toPreview()
    }

}
