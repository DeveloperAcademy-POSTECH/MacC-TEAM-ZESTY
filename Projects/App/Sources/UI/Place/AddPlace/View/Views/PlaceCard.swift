//
//  PlaceCard.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/28.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class PlaceCardView: UIView {
    
    private let isSE = UIScreen.main.isHeightLessThan670pt
    
    // MARK: - Properties

    private lazy var iconView: UIImageView = {
        $0.image = UIImage(.img_categoryfriends_western)
        $0.contentMode = .scaleAspectFit
        $0.layer.applyFigmaShadow(color: .shadow, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        return $0
    }(UIImageView())
    
    private lazy var categoryTagLabel: BasePaddingLabel = {
        $0.text = "일식"
        $0.font = .systemFont(ofSize: 11, weight: .bold)
        $0.textColor = .staticLabel
        $0.backgroundColor = .point
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(BasePaddingLabel())
    
    private lazy var placeNameLabel: UILabel = {
        $0.text = "요기쿠시동"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: isSE ? 20 : 22, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var addressLabel: UILabel = {
        $0.text = "경북 포항시 남구 효자동 11길 24-1 1층 요기쿠시동 "
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: isSE ? 10 : 12, weight: .regular)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var orgTitle: UILabel = {
        $0.text = "Orgnization"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: isSE ? 9 : 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var creatorTitle: UILabel = {
        $0.text = "Registered by"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: isSE ? 9 : 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var dateTitle: UILabel = {
        $0.text = "Date"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: isSE ? 9 : 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var orgLabel: UILabel = {
        $0.text = "대학이름"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: isSE ? 13 : 16, weight: .medium)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var creatorLabel: UILabel = {
        $0.text = "만든사람"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: isSE ? 13 : 16, weight: .medium)
        return $0
    }(UILabel())
    
    private lazy var dateLabel: UILabel = {
        $0.text = "YYYY.MM.DD"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: isSE ? 13 : 16, weight: .medium)
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    init() {
        super.init(frame: .zero)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    func setup(with place: PlaceResult) {
        categoryTagLabel.text = place.category.name
        placeNameLabel.text = place.name
        addressLabel.text = place.address
        orgLabel.text = place.organizationName
        creatorLabel.text = place.creator
        dateLabel.text = place.createdAt.getDateToString(format: "YYYY.MM.dd")
        iconView.kf.setImage(with: URL(string: place.category.imageURL ?? "https://user-images.githubusercontent.com/63157395/197410857-e13c1bbb-b19a-4c59-a493-77501a4a529b.png"))
        
    }
    
}

// MARK: - UI Function

extension PlaceCardView {
    
    private func configureUI() {
        
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderColor = UIColor.green.cgColor
        layer.applyFigmaShadow(color: .shadow, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        backgroundColor = .cardFill
      
    }
    
    private func createLayout() {
        self.addSubviews([iconView, categoryTagLabel, placeNameLabel, addressLabel, orgTitle, creatorTitle, dateTitle, orgLabel, creatorLabel, dateLabel])
        
        addressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(iconView.snp.leading).offset(-10)
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addressLabel.snp.top).offset(-4)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(iconView.snp.leading).offset(-10)
        }
        
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(65)
            make.trailing.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        categoryTagLabel.snp.makeConstraints { make in
            make.bottom.equalTo(placeNameLabel.snp.top).offset(-4)
            make.leading.equalToSuperview().inset(20)
        }
        
        orgTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        orgLabel.snp.makeConstraints { make in
            make.top.equalTo(orgTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
        }
        
        creatorTitle.snp.makeConstraints { make in
            make.top.equalTo(orgLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(creatorTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
        }
        
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(creatorLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
        }

    }
    
}

// MARK: - Previews

/*
#if DEBUG
import SwiftUI

struct PlaceCardViewPreview: PreviewProvider {
    
    static var previews: some View {
        PlaceCardView()
    }
    
}
#endif
*/
