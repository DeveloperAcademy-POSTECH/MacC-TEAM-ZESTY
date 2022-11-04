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
import Kingfisher

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
                guard let self = self else { return }
                self.fillUI(with: result)
            }
            .store(in: &cancelBag)
        
        viewModel.imageSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                guard let self = self else { return }
                self.reconfigureUI(for: false)
                self.remakeLayout(with: false)
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.reconfigureUI(for: true)
                self.remakeLayout(with: true)
            })
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function

extension ReviewCardView {
    
    private func fillUI(with result: ReviewRegisterViewModel.Result) {
        menuImageView.load(url: result.image)
        evaluationImageView.image = result.evaluation.image
        nicknameLabel.text = result.reviewer
        dateLabel.text = result.registeredAt
        categoryLabel.text = result.category
        categoryLabel.backgroundColor = .red
        placeNameLabel.text = result.placeName
        placeAddressLabel.text = result.placeAddress
    }
    
    private func configureUI() {
        clipsToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .white
        addShadow(opacity: 0.6, radius: 3)
        
        menuImageView.clipsToBounds = true
        menuImageView.layer.cornerRadius = 16
        menuImageView.contentMode = .scaleAspectFill
        
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
        nicknameLabel.font = .preferredFont(forTextStyle: .callout).bold()

        dateStaticLabel.text = "Date"
        dateStaticLabel.font = .preferredFont(forTextStyle: .caption2)
        dateStaticLabel.textColor = .clear
        dateLabel.font = .preferredFont(forTextStyle: .callout).bold()
        
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
        placeNameLabel.numberOfLines = 0
        placeAddressLabel.font = .preferredFont(forTextStyle: .caption1)
        placeAddressLabel.numberOfLines = 0
    }
    
    private func reconfigureUI(for isImageExist: Bool) {
        nicknameStaticLabel.textColor = isImageExist ? .white : .secondaryLabel
        nicknameLabel.textColor = isImageExist ? .white : .label
        placeNameLabel.textColor = isImageExist ? .white : .label
        placeAddressLabel.textColor = isImageExist ? .white : .secondaryLabel
        
        backgroundView.isHidden = !isImageExist
        menuImageView.isHidden = !isImageExist
        dateStaticLabel.textColor = isImageExist ? .white : .clear
        dateLabel.textColor = isImageExist ? .white : .clear
        
    }
    
    private func createLayout() {
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
        
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }

        dateStaticLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        placeStackView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(30)
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
        
        evaluationImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(evaluationImageView.snp.width)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        menuImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func remakeLayout(with isImageExist: Bool) {
        if isImageExist {
            evaluationImageView.snp.remakeConstraints {
                $0.trailing.bottom.equalToSuperview().inset(30)
                $0.width.equalToSuperview().multipliedBy(0.2)
                $0.height.equalTo(evaluationImageView.snp.width)
            }
            placeStackView.snp.remakeConstraints {
                $0.leading.bottom.equalToSuperview().inset(30)
                $0.trailing.equalTo(evaluationImageView.snp.leading).offset(-10)
            }
        } else {
            evaluationImageView.snp.remakeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(0.8)
                $0.width.equalToSuperview().multipliedBy(0.4)
                $0.height.equalTo(evaluationImageView.snp.width)
            }
            placeStackView.snp.remakeConstraints {
                $0.horizontalEdges.bottom.equalToSuperview().inset(30)
            }
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
