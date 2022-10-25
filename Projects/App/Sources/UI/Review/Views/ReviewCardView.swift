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
    
    private let nameStackView = UIStackView()
    private let nicknameStaticLabel = UILabel()
    private let nicknameLabel = UILabel()
    
    private let dateStackView = UIStackView()
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
    
    init(menu: String? = nil, image: UIImage? = nil) {
        super.init(frame: .zero)
        configureUI(with: image)
        createLayout(isMenuImageExist: image != nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Function
    
}

// MARK: - UI Function

extension ReviewCardView {
    
    private func configureUI(with image: UIImage?) {
        let isImage = image != nil
        
        clipsToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .white
        addShadow(opacity: 0.6, radius: 3)
        
        menuImageView.image = image
        menuImageView.clipsToBounds = true
        menuImageView.layer.cornerRadius = 16
        backgroundView.backgroundColor = .black
        backgroundView.clipsToBounds = true
        backgroundView.layer.opacity = 0.4
        backgroundView.layer.cornerRadius = 16
        
        nameStackView.axis = .vertical
        nameStackView.distribution = .equalSpacing
        nameStackView.spacing = 4
        
        dateStackView.axis = .vertical
        dateStackView.distribution = .equalSpacing
        dateStackView.spacing = 4
        
        nicknameStaticLabel.text = "Reviewed by"
        nicknameStaticLabel.font = .preferredFont(forTextStyle: .caption2)
        nicknameStaticLabel.textColor = isImage ? .white : .secondaryLabel
        nicknameLabel.text = "아보카도"
        nicknameLabel.font = .preferredFont(forTextStyle: .callout).bold()
        nicknameLabel.textColor = isImage ? .white : .label

        dateStaticLabel.text = "Date"
        dateStaticLabel.font = .preferredFont(forTextStyle: .caption2)
        dateStaticLabel.textColor = .white
        dateLabel.text = "2020.10.21"
        dateLabel.font = .preferredFont(forTextStyle: .callout).bold()
        dateLabel.textColor = .white
        
        evaluationImageView.image = UIImage(.img_reviewfriends_good)
        evaluationImageView.addShadow(opacity: 0.1, radius: 2)
        
        placeStackView.axis = .vertical
        placeStackView.alignment = .leading
        placeStackView.distribution = .equalSpacing
        placeStackView.spacing = 4
        
        categoryLabel.text = "일식"
        categoryLabel.font = .boldSystemFont(ofSize: 9)
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.backgroundColor = .red
        categoryLabel.textColor = .white
        
        placeNameLabel.text = "요기쿠시동"
        placeNameLabel.font = .preferredFont(forTextStyle: .title2).bold()
        placeNameLabel.textColor = isImage ? .white : .label
        placeNameLabel.numberOfLines = 0
        placeAddressLabel.text = "경북 포항시 남구 효자동길6번길 34-1 1층 요기쿠시동"
        placeAddressLabel.font = .preferredFont(forTextStyle: .caption1)
        placeAddressLabel.textColor = isImage ? .white : .secondaryLabel
        placeAddressLabel.numberOfLines = 0
    }
    
    private func createLayout(isMenuImageExist: Bool) {
        addSubviews([
            menuImageView, backgroundView, nameStackView, dateStackView,
            placeStackView, evaluationImageView
        ])
        nameStackView.addArrangedSubviews([
            nicknameStaticLabel, nicknameLabel
        ])
        dateStackView.addArrangedSubviews([
            dateStaticLabel, dateLabel
        ])
        placeStackView.addArrangedSubviews([
            categoryLabel, placeNameLabel, placeAddressLabel
        ])
        
        nameStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(30)
        }
        nicknameStaticLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        nicknameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        if isMenuImageExist {
            dateStackView.snp.makeConstraints {
                $0.top.equalTo(nameStackView.snp.bottom).offset(10)
                $0.horizontalEdges.equalToSuperview().inset(30)
            }
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            menuImageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            dateStaticLabel.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
            }
            dateLabel.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
            }
            evaluationImageView.snp.makeConstraints {
                $0.trailing.bottom.equalToSuperview().inset(30)
                $0.width.equalToSuperview().multipliedBy(0.2)
                $0.height.equalTo(evaluationImageView.snp.width)
            }
            placeStackView.snp.makeConstraints {
                $0.leading.bottom.equalToSuperview().inset(30)
                $0.trailing.equalTo(evaluationImageView.snp.leading).offset(-10)
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
            }
        }
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.greaterThanOrEqualTo(33)
        }
        placeNameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        placeAddressLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ReviewCardPreview: PreviewProvider {
    
    static var previews: some View {
        ReviewCardView(image: UIImage(.img_mockmenu)).toPreview()
            .frame(width: 300, height: 400)
//            .frame(width: 250, height: 320)
    }
    
}
#endif
