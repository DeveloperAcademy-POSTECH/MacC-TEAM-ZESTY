//
//  CategoryIconCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import Firebase
import SnapKit
import DesignSystem

final class CategoryIconCell: UICollectionViewCell {
    
    private var categoryId = 0
    
    private let input: PassthroughSubject<AddPlaceViewModel.Input, Never> = .init()
    
    private let isSE = UIScreen.main.isLessThan376pt && !UIDevice.current.hasNotch
    
    private let cellView = UIView()
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.textColor = .label
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        return $0
    }(UILabel())
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.contentView.backgroundColor = .friendsSelection
                    self?.nameLabel.textColor = .reverseLabel
                    self?.input.send(.categoryCellDidTap(category: self?.categoryId ?? 0))
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.contentView.backgroundColor = .clear
                    self.nameLabel.textColor = .label
                }
            }
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                AnalyticsParameterItemID: categoryId,
                AnalyticsParameterContentType: self.nameLabel.text ?? ""
            ])
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubviews([imageView, nameLabel])
            
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.isWiderThan425pt ? 25 : 15 )
            $0.centerX.equalToSuperview()
            $0.height.equalTo(isSE ? 50 : 65)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func configure(with category: Category, viewModel: AddPlaceViewModel) {
        _ = viewModel.transform(input: input.eraseToAnyPublisher())
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.categoryId = category.id
        self.nameLabel.text = category.name
        self.imageView.kf.setImage(with: URL(string: category.imageURL ?? "https://user-images.githubusercontent.com/63157395/197410857-e13c1bbb-b19a-4c59-a493-77501a4a529b.png"))
    }

}
