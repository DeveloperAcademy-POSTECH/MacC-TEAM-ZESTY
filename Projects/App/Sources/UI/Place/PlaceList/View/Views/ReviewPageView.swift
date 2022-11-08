//
//  ReviewPageView.swift
//  App
//
//  Created by 리아 on 2022/10/27.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit
import DesignSystem

final class ReviewPageView: UIView {
    
    // MARK: - Properties
    private lazy var mainView = UIView()
    private lazy var menuLabel = UILabel()
    private lazy var reviewImageView = UIImageView()
    private lazy var gradientView = GradientView(gradientStartColor: .clear, gradientEndColor: .black)
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - UI Functions

extension ReviewPageView {
    
    func setUp(with review: Review) {
        reviewImageView.load(url: review.imageURL)
        let isMenuEmpty = review.menuName?.isEmpty ?? true
        gradientView.isHidden = isMenuEmpty
        menuLabel.text = review.menuName
    }
    
    func setEmptyView() {
        reviewImageView.image = UIImage(.img_categoryfriends)
        gradientView.isHidden = true
    }
    
    private func configure() {
        clipsToBounds = true
        configureGradientView()
        
        reviewImageView.contentMode = .scaleAspectFill
        menuLabel.numberOfLines = 1
        menuLabel.font = .preferredFont(forTextStyle: .footnote)
        menuLabel.textColor = .zestyColor(.whiteEBEBF5)
        menuLabel.layer.opacity = 0.6
    }
    
    private func createLayout() {
        addSubviews([reviewImageView, gradientView, menuLabel])
        
        reviewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(menuLabel.snp.top).offset(-40)
        }
        
        menuLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(80)
            $0.bottom.equalToSuperview()
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

struct ReviewPagePreview: PreviewProvider {
    
    static var previews: some View {
        ReviewPageView().toPreview()
            .frame(width: 300, height: 300)
    }
    
}
#endif
