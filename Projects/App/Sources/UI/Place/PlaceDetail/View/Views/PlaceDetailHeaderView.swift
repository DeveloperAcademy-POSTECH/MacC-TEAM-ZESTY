//
//  PlaceDetailHeaderView.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit
import DesignSystem

class PlaceDetailHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    private lazy var placeView = ShadowView()
    private var kakaoUrl = ""
    private var naverUrl = ""
    
    private lazy var placeNameLabel: UILabel = {
        $0.text = "(가게이름없음)"
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        return $0
    }(UILabel())
    
    private lazy var evaluationTitleLabel: UILabel = {
        $0.text = "평가"
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .zestyColor(.gray3C3C43)?.withAlphaComponent(0.6)
        return $0
    }(UILabel())
    
    private lazy var evaluationStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private var goodView = EvaluationItemView()
    private var sosoView = EvaluationItemView()
    private var badView = EvaluationItemView()
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(.img_good)
        return $0
    }(UIImageView())
    
    private lazy var addressLabel: UILabel = {
        $0.text = "경북 포항시 남구 효자동 11길 24-1 1층 요기쿠시동"
        $0.textColor = .zestyColor(.gray3C3C43)?.withAlphaComponent(0.6)
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private lazy var reportButton: UIButton = {
        let customAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 11, weight: .regular),
            .foregroundColor: UIColor.zestyColor(.gray3C3C43)?.withAlphaComponent(0.3) ?? UIColor.systemGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "정보가 잘못됐나요?",
            attributes: customAttributes
        )
        $0.setAttributedTitle(attributeString, for: .normal)
        $0.addTarget(self, action: #selector(reportPlaceDetail), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var addressView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var naverButton: UIButton = {
        $0.setImage(UIImage(.btn_navermap), for: .normal)
        $0.addTarget(self, action: #selector(openNaverMap), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    private lazy var kakaoButton: UIButton = {
        $0.setImage(UIImage(.btn_kakaomap), for: .normal)
        $0.addTarget(self, action: #selector(openKakaoMap), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    private lazy var categoryCollectionView = CategoryCollectionView()
    
    private lazy var reviewTitleLabel: UILabel = {
        $0.text = "리뷰"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    @objc func reportPlaceDetail() {
        UrlUtils.openExternalLink(urlStr: "mailto:kingbobne@gmail.com" )
    }
    
    @objc func openKakaoMap() {
        UrlUtils.openExternalLink(urlStr: kakaoUrl)
    }
    
    @objc func openNaverMap() {
        UrlUtils.openExternalLink(urlStr: naverUrl)
    }
    
}

extension PlaceDetailHeaderView {
    
    public func setUp(with place: Place) {
        
        categoryCollectionView.setupData(tagList: place.category)
        placeNameLabel.text = place.name
        
        addressLabel.text = place.address
        kakaoUrl = "https://map.kakao.com/link/to/\(place.name),\(place.lat),\(place.lan)"
        naverUrl = "http://app.map.naver.com/launchApp/?version=11&menu=navigation&elat=\(place.lat)&elng=\(place.lan)&etitle=\(place.name)"
        
        goodView.configure(with: EvaluationViewModel(evaluation: .good, count: place.evaluationSum.good))
        sosoView.configure(with: EvaluationViewModel(evaluation: .soso, count: place.evaluationSum.soso))
        badView.configure(with: EvaluationViewModel(evaluation: .bad, count: place.evaluationSum.bad))
    }
        
}

// MARK: - UI Function

extension PlaceDetailHeaderView {
    
    private func configureUI() {

    }
    
    private func createLayout() {
        self.addSubviews([placeView, reviewTitleLabel])
        
        placeView.addSubviews([placeNameLabel, evaluationTitleLabel, evaluationStackView, addressView, reportButton, categoryCollectionView])
        
        placeView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(366)
        }
        
        reviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(44)
            $0.leading.equalToSuperview()
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(30)
        }
        
        evaluationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        evaluationStackView.snp.makeConstraints {
            $0.top.equalTo(evaluationTitleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(70)
        }
        
        evaluationStackView.addArrangedSubviews([goodView, sosoView, badView])
        
        goodView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        sosoView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        badView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        addressView.snp.makeConstraints {
            $0.top.equalTo(evaluationStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(36)
        }
        
        addressView.addArrangedSubviews([addressLabel, naverButton, kakaoButton])
        addressView.setCustomSpacing(8, after: addressLabel)
        
        addressLabel.snp.makeConstraints {
            $0.width.equalTo(190)
        }
        
        naverButton.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalTo(addressView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
    }
    
}
