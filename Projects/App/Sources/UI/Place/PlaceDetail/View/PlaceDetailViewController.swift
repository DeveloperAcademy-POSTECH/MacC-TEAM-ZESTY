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

final class PlaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cancelBag = Set<AnyCancellable>()
    private let viewModel = PlaceDetailViewModel()
    
    private lazy var placeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "test-pasta")
        return $0
    }(UIImageView())
    
    private lazy var placeNameLabel: UILabel = {
        $0.text = "가게이름"
        return $0
    }(UILabel())
    
    private lazy var addressLabel: UILabel = {
        $0.text = "경북 포항시 남구 효자동 11길 24-1 1층 요기쿠시동"
        return $0
    }(UILabel())
    
    private lazy var reportButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("제보하기", for: .normal)
        $0.addTarget(self, action: #selector(reportPlaceDetail), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var naverButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("네이버지도바로가기", for: .normal)
        $0.addTarget(self, action: #selector(reportPlaceDetail), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var kakaoButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("카카오지도바로가기", for: .normal)
        $0.addTarget(self, action: #selector(reportPlaceDetail), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var addReviewButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("리뷰 남기기 버튼", for: .normal)
        $0.addTarget(self, action: #selector(reportPlaceDetail), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var categoryCollectionView = CategoryCollectionView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        bind()
    }
    
    // MARK: - Function
    
    @objc func reportPlaceDetail() {
        // !!!: 시뮬레이터에서는 애플 로그인해야 실행됨
        if let url = URL(string: "mailto:kingbobne@gmail.com?subject=%5B%EC%A0%9C%EB%B3%B4%ED%95%98%EA%B8%B0%5D%20%EB%A7%9B%EC%A7%91%EC%A0%95%EB%B3%B4%EC%98%A4%EB%A5%98%20%EC%A0%9C%EB%B3%B4%ED%95%98%EA%B8%B0&body=%23%23%20%EC%A0%9C%EB%B3%B4%EC%9E%90%20%EC%84%B1%ED%95%A8%20%ED%98%B9%EC%9D%80%20%EB%8B%89%EB%84%A4%EC%9E%84%20%2F%20%EC%86%8C%EC%86%8D%EB%8C%80%ED%95%99%0D%0A%0D%0A%0D%0A%23%23%20%EB%AC%B8%EC%A0%9C%EA%B0%80%20%EC%9E%88%EB%8A%94%20%EB%A7%9B%EC%A7%91%EC%9D%80%20%EC%96%B4%EB%94%94%EC%9D%B8%EA%B0%80%EC%9A%94%3F%0D%0A%0D%0A%0D%0A%23%23%20%EC%A0%9C%EB%B3%B4%20%EB%82%B4%EC%9A%A9%0D%0A") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
}

extension PlaceDetailViewController {
    
    // MARK: - UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        categoryCollectionView.setupData(tagList: ["한식", "분식"])
    }
    
    private func configureLayout() {
        view.addSubviews([placeImageView, placeNameLabel, addressLabel,
                          reportButton, naverButton, kakaoButton, addReviewButton, categoryCollectionView])
        
        placeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        naverButton.snp.makeConstraints {
            $0.top.equalTo(reportButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(naverButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        addReviewButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(addReviewButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(100)
        }
        
    }
    
}

// MARK: - Bind
extension PlaceDetailViewController {
    
    private func bind() {
        
    }
    
}
