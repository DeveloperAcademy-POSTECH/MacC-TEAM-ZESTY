//
//  PlaceCell.swift
//  App
//
//  Created by 리아 on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit
import DesignSystem

final class PlaceCell: UICollectionViewCell {
    // TODO: 리뷰가 없는 상황을 가정한 cell입니다. 변경 예정
    
    // MARK: - Properties
    
    static let identifier = "PlaceCell"
     
    private lazy var containerView = UIView()
    
    private lazy var scrollView = UIScrollView()
    private lazy var pageStackView = UIStackView()
    private lazy var pageControl = UIPageControl()
    private lazy var reviewViews = [ReviewPageView(), ReviewPageView(), ReviewPageView()]
    
    private lazy var middelView = UIView()
    private lazy var gradientStackView = UIStackView()
    private lazy var bottomView = UIView()
    
    private lazy var placeNameLabel = UILabel()
    
    private lazy var emojiStackView = UIStackView()
    private lazy var goodEmojiStackView = EmojiCountStackView(type: .good)
    private lazy var sosoEmojiStackView = EmojiCountStackView(type: .soso)
    private lazy var badEmojiStackView = EmojiCountStackView(type: .bad)
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
    }
    
}

// MARK: - UI Function

extension PlaceCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        
        pageControl.currentPage = Int((round(pageFraction)))
        
        scrollView.bounces = scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < pageWidth
    }
    
}

extension PlaceCell {

    func setUp(with place: Place) {
        placeNameLabel.text = place.name
        goodEmojiStackView.setUp(count: place.evaluationSum.good)
        sosoEmojiStackView.setUp(count: place.evaluationSum.soso)
        badEmojiStackView.setUp(count: place.evaluationSum.bad)
        
        if place.reviews.isEmpty {
            reviewViews[0].setEmptyView()
            pageStackView.addArrangedSubview(reviewViews[0])
            reviewViews[0].snp.makeConstraints {
                $0.verticalEdges.equalToSuperview()
                $0.width.equalTo(containerView.snp.width)
            }
        }
        
        for index in 0..<place.reviews.count {
            let review = place.reviews[index]
            reviewViews[index].setUp(with: review)
            pageStackView.addArrangedSubview(reviewViews[index])
            reviewViews[index].snp.makeConstraints {
                $0.verticalEdges.equalToSuperview()
                $0.width.equalTo(containerView.snp.width)
            }
        }
        pageControl.numberOfPages = place.reviews.count
    }

    private func configureUI() {
        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isUserInteractionEnabled = false
        scrollView.delegate = self
        
        pageStackView.axis = .horizontal
        pageStackView.distribution = .fillEqually
        
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
        containerView.addSubviews([scrollView, bottomView, pageControl])
        scrollView.addSubview(pageStackView)
        bottomView.addSubviews([placeNameLabel, emojiStackView])
        emojiStackView.addArrangedSubviews([goodEmojiStackView, sosoEmojiStackView, badEmojiStackView])

        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.verticalEdges.equalToSuperview().inset(15)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(containerView.snp.width)
        }
        pageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(containerView.snp.width)
        }
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).priority(.medium)
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
