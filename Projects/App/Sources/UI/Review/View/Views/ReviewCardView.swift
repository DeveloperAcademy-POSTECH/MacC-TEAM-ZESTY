//
//  ReviewCardView.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class ReviewCardView: UIView {
    
    // MARK: - Properties
    
    private let cancelBag = Set<AnyCancellable>()
    private let viewModel: ReviewRegisterViewModel
    
    private let userStackView = UIStackView()
    private let nicknameStaticLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let dateStaticLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let placeStackView = UIStackView()
    private let categoryLabel = PaddingLabel()
    private let placeNameLabel = UILabel()
    private let placeAddressLabel = UILabel()
    
    private let evaluationImageView = UIImageView()
    private let backgroundView = UIView()
    private let menuImageView = UIImageView()
    
    // MARK: - LifeCycle
    
    init(viewModel: ReviewRegisterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureUI()
        createLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    
}

extension ReviewCardView {
    
    private func bind() {
        menuImageView.image = viewModel.result.image
        nicknameLabel.text = viewModel.result.reviewer
        dateLabel.text = viewModel.result.registeredAt
        categoryLabel.text = viewModel.result.category
        categoryLabel.backgroundColor = .red
        placeNameLabel.text = viewModel.result.placeName
        placeAddressLabel.text = viewModel.result.placeAddress
    }
    
}

// MARK: - UI Function

extension ReviewCardView {
    
    private func configureUI() {
        let isMenuImageExist = viewModel.image != nil
        
        clipsToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .white
        addShadow(opacity: 0.6, radius: 3)
        
        menuImageView.clipsToBounds = true
        menuImageView.layer.cornerRadius = 16
        backgroundView.backgroundColor = .black
        backgroundView.clipsToBounds = true
        backgroundView.layer.opacity = 0.6
        backgroundView.layer.cornerRadius = 16
        
        userStackView.axis = .vertical
        userStackView.distribution = .equalSpacing
        userStackView.spacing = 4
        
        nicknameStaticLabel.text = "Reviewed by"
        nicknameStaticLabel.font = .preferredFont(forTextStyle: .caption2)
        nicknameStaticLabel.textColor = isMenuImageExist ? .white : .secondaryLabel
        nicknameLabel.font = .preferredFont(forTextStyle: .callout).bold()
        nicknameLabel.textColor = isMenuImageExist ? .white : .label

        dateStaticLabel.text = "Date"
        dateStaticLabel.font = .preferredFont(forTextStyle: .caption2)
        dateStaticLabel.textColor = .white
        dateLabel.font = .preferredFont(forTextStyle: .callout).bold()
        dateLabel.textColor = .white
        
        evaluationImageView.image = UIImage(.img_reviewfriends_good)
        evaluationImageView.addShadow(opacity: 0.1, radius: 2)
        
        placeStackView.axis = .vertical
        placeStackView.alignment = .leading
        placeStackView.distribution = .equalSpacing
        placeStackView.spacing = 4
        
        categoryLabel.font = .boldSystemFont(ofSize: 9)
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.textColor = .white
        
        placeNameLabel.font = .preferredFont(forTextStyle: .title2).bold()
        placeNameLabel.textColor = isMenuImageExist ? .white : .label
        placeNameLabel.numberOfLines = 2
        placeAddressLabel.font = .preferredFont(forTextStyle: .caption1)
        placeAddressLabel.textColor = isMenuImageExist ? .white : .secondaryLabel
        placeAddressLabel.numberOfLines = 2
    }
    
    private func createLayout() {
        let isMenuImageExist = viewModel.image != nil
        
        addSubviews([
            menuImageView, backgroundView, userStackView, placeStackView,
            evaluationImageView
        ])
        userStackView.addArrangedSubviews([
            nicknameStaticLabel, nicknameLabel, dateStaticLabel, dateLabel
        ])
        placeStackView.addArrangedSubviews([
            categoryLabel, placeNameLabel, placeAddressLabel
        ])
        
        userStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(30)
        }
        nicknameStaticLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(13)
        }
        nicknameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(21)
        }
        
        if isMenuImageExist {
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            menuImageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            dateStaticLabel.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(13)
            }
            dateLabel.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(21)
            }
            evaluationImageView.snp.makeConstraints {
                $0.trailing.bottom.equalToSuperview().inset(30)
                $0.width.equalToSuperview().multipliedBy(0.2)
                $0.height.equalTo(evaluationImageView.snp.width)
            }
            placeStackView.snp.makeConstraints {
                $0.leading.bottom.equalToSuperview().inset(30)
                $0.trailing.equalTo(evaluationImageView.snp.leading).offset(-10)
                $0.height.greaterThanOrEqualTo(88)
            }
        } else {
            evaluationImageView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(0.8)
                $0.width.equalToSuperview().multipliedBy(0.4)
                $0.height.equalTo(evaluationImageView.snp.width)
            }
            placeStackView.snp.makeConstraints {
                $0.horizontalEdges.bottom.equalToSuperview().inset(30)
                $0.height.greaterThanOrEqualTo(88)
            }
        }
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.greaterThanOrEqualTo(33)
        }
        placeNameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(28)
        }
        placeAddressLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(16)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ReviewCardPreview: PreviewProvider {
    
    static var previews: some View {
        ReviewCardView(viewModel: ReviewRegisterViewModel(placeId: 0, placeName: "요기쿠시동")).toPreview()
            .frame(width: 300, height: 400)
    }
    
}
#endif
