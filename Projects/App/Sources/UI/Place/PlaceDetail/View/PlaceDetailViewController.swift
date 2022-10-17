//
//  PlaceDetailViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit
import DesignSystem

final class PlaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cancelBag = Set<AnyCancellable>()
    private let viewModel = PlaceDetailViewModel()
    private let place: Place
    
    private lazy var placeView = ShadowView()
    
    private lazy var placeNameLabel: UILabel = {
        $0.text = "(가게이름없음)"
        $0.font = .systemFont(ofSize: 22, weight: .bold)
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
    
    private lazy var goodView = EvaluationItemView(with: EvaluationViewModel(evaluation: .good, count: place.evaluationSum.good))
    private lazy var sosoView = EvaluationItemView(with: EvaluationViewModel(evaluation: .soso, count: place.evaluationSum.soso))
    private lazy var badView = EvaluationItemView(with: EvaluationViewModel(evaluation: .bad, count: place.evaluationSum.bad))
    
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
    
    private lazy var addReviewButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("리뷰 남기기 버튼", for: .normal)
        $0.addTarget(self, action: #selector(addReviewButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var categoryCollectionView = CategoryCollectionView()
    
    // MARK: - Initialization
    
    init(place: Place) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bind()
    }
    
    // MARK: - Function
    
    @objc func reportPlaceDetail() {
        UrlUtils.openExternalLink(urlStr: "mailto:kingbobne@gmail.com" )
    }
    
    @objc func openKakaoMap() {
        UrlUtils.openExternalLink(urlStr: "https://map.kakao.com/link/to/\(place.name),\(place.lat),\(place.lan)")
    }
    
    @objc func openNaverMap() {
        UrlUtils.openExternalLink(urlStr: "http://app.map.naver.com/launchApp/?version=11&menu=navigation&elat=\(place.lat)&elng=\(place.lan)&etitle=\(place.name)")
    }
    
    @objc func addReviewButtonDidTap() {
        // TODO: - 리뷰 남기기 버튼 눌렀을때 동작추가
    }
}

extension PlaceDetailViewController {
    
    // MARK: - UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        categoryCollectionView.setupData(tagList: place.category)
        placeNameLabel.text = place.name
    }
    
    private func createLayout() {
        view.addSubviews([placeView, addReviewButton])
        
        placeView.addSubviews([placeNameLabel, evaluationTitleLabel, evaluationStackView, addressView, reportButton, categoryCollectionView])
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(356)
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
        
        addReviewButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    
}

// MARK: - Bind
extension PlaceDetailViewController {
    
    private func bind() {
        
    }
    
}
