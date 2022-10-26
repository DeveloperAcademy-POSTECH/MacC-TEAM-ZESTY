//
//  PlaceInfoHeaderView.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/21.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit
import DesignSystem

final class PlaceInfoHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private let viewModel = PlaceDetailViewModel()
    private let input: PassthroughSubject<PlaceDetailViewModel.Input, Never> = .init()
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var placeView = UIView()
    private var kakaoUrl = ""
    private var naverUrl = ""
    
    private lazy var categoryTagLabel: BasePaddingLabel = {
        $0.font = .systemFont(ofSize: 11, weight: .bold)
        $0.textColor = .white
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        return $0
    }(BasePaddingLabel())
    
    private lazy var addReviewButton: UIButton = {
        $0.setImage(UIImage(.btn_side_plus), for: .normal)
        $0.addTarget(self, action: #selector(addReviewButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))

    private lazy var placeNameLabel: UILabel = {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 26, weight: .bold)
        return $0
    }(UILabel())
    
    private var goodView = EvaluationItemView()
    private var sosoView = EvaluationItemView()
    private var badView = EvaluationItemView()
    
    private lazy var addressView: UIView = {
        $0.backgroundColor = .zestyColor(.grayF6)
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private lazy var addressLabel: UILabel = {
        $0.text = "경북 포항시 남구 효자동 11길 24-1 1층 요기쿠시동"
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var naverButton: UIButton = {
        $0.setImage(UIImage(.btn_navermap), for: .normal)
        $0.isUserInteractionEnabled = true
        $0.addTarget(self, action: #selector(openNaverMap), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    private lazy var kakaoButton: UIButton = {
        $0.setImage(UIImage(.btn_kakaomap), for: .normal)
        $0.isUserInteractionEnabled = true
        $0.addTarget(self, action: #selector(openKakaoMap), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    private lazy var reviewTitleLabel: UILabel = {
        $0.text = "리뷰"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 26, weight: .bold)
        return $0
    }(UILabel())
    
    private lazy var lineView: UIView = {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
        return $0
    }(UIView())
    
    // MARK: - LifeCycle
    
    override init(reuseIdentifier: String?) {
       super.init(reuseIdentifier: reuseIdentifier)
        bind()
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
        kakaoButton.showAnimation {
            UrlUtils.openExternalLink(urlStr: self.kakaoUrl)
        }
    }
    
    @objc func openNaverMap() {
        naverButton.showAnimation {
            UrlUtils.openExternalLink(urlStr: self.naverUrl)
        }
    }
    
    @objc func addReviewButtonDidTap() {
        input.send(.addReviewBtnDidTap)
    }
    
    public func setUp(with place: Place) {
        categoryTagLabel.text = place.category[0].name
        placeNameLabel.text = place.name
        addressLabel.text = place.address
        kakaoUrl = "https://map.kakao.com/link/to/\(place.name),\(place.lat),\(place.lan)"
        naverUrl = "http://app.map.naver.com/launchApp/?version=11&menu=navigation&elat=\(place.lat)&elng=\(place.lan)&etitle=\(place.name)"
        goodView.configure(with: EvaluationViewModel(evaluation: .good, count: place.evaluationSum.good))
        sosoView.configure(with: EvaluationViewModel(evaluation: .soso, count: place.evaluationSum.soso))
        badView.configure(with: EvaluationViewModel(evaluation: .bad, count: place.evaluationSum.bad))
    }
    
}

// MARK: - Binding
extension PlaceInfoHeaderView {
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
    }
}

// MARK: - UI Function

extension PlaceInfoHeaderView {
    
    private func configureUI() {
        self.backgroundColor = .zestyColor(.background)
    }
    
    private func createLayout() {

        self.addSubviews([placeView, addReviewButton])
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(330)
        }
        
        addReviewButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(1)
            $0.height.equalTo(65)
        }
        
        placeView.addSubviews([categoryTagLabel, placeNameLabel, categoryTagLabel, goodView, sosoView, badView, addressView, lineView, reviewTitleLabel, lineView])
        
        placeView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(320)
        }
        
        categoryTagLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
            $0.height.equalTo(24)
        }

        placeNameLabel.snp.makeConstraints {
            $0.top.equalTo(categoryTagLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }

        goodView.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        sosoView.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(20)
            $0.leading.equalTo(goodView.snp.trailing).offset(10)
            $0.width.equalTo(60)
        }
        
        badView.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(20)
            $0.leading.equalTo(sosoView.snp.trailing).offset(10)
            $0.width.equalTo(60)
        }
        
        addressView.snp.makeConstraints {
            $0.top.equalTo(goodView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }

        addressView.addSubviews([addressLabel, naverButton, kakaoButton])
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(kakaoButton.snp.leading).offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(200)
        }
        
        naverButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(36)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.trailing.equalTo(naverButton.snp.leading).offset(-8)
            $0.width.height.equalTo(36)
            $0.top.bottom.equalToSuperview().inset(16)
        }

        reviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.width.equalTo(20)
            $0.centerX.equalTo(reviewTitleLabel.snp.centerX)
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(5)
        }
        
    }
    
}
