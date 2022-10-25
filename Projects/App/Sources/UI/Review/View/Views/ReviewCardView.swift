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
    
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: ReviewRegisterViewModel
    
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
        viewModel.$result
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                print(result)
                guard let self = self else { return }
                
                self.menuImageView.image = result.image
                self.evaluationImageView.image = result.evaluation.image
                self.nicknameLabel.text = result.reviewer
                self.dateLabel.text = result.registeredAt
                self.categoryLabel.text = result.category
                self.categoryLabel.backgroundColor = .red
                self.placeNameLabel.text = result.placeName
                self.placeAddressLabel.text = result.placeAddress
            }
            .store(in: &cancelBag)
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
        placeNameLabel.numberOfLines = 0
        placeAddressLabel.font = .preferredFont(forTextStyle: .caption1)
        placeAddressLabel.textColor = isMenuImageExist ? .white : .secondaryLabel
        placeAddressLabel.numberOfLines = 0
    }
    
    private func createLayout() {
        let isMenuImageExist = viewModel.image != nil
        
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

fileprivate extension Evaluation {
    
    var image: UIImage? {
        switch self {
        case .good:
            return UIImage(.img_reviewfriends_good)
        case .soso:
            return UIImage(.img_reviewfriends_soso)
        case .bad:
            return UIImage(.img_reviewfriends_bad)
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
