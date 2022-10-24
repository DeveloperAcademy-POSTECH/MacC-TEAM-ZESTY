//
//  ReviewCardViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import DesignSystem
import SnapKit

final class ReviewCardViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let safeArea = UIView()
    private let titleView = MainTitleView(title: "리뷰 등록 완료 🎉")
    private let cardView = ReviewCardView()
    private let saveButton = UIButton()
    private let completeButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    @objc func saveButtonTouched() {
    }
    
    @objc func completeButtonTouched() {
    }
    
}

// MARK: - UI Function

extension ReviewCardViewController {
    
    private func configureUI() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.red])
        let downloadImage = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        saveButton.setImage(downloadImage, for: .normal)
        saveButton.setTitle(" 리뷰 카드 저장하기", for: .normal)
        saveButton.setTitleColor(.red, for: .normal)
        saveButton.titleLabel?.font = .preferredFont(forTextStyle: .footnote).bold()
        saveButton.addTarget(self, action: #selector(saveButtonTouched), for: .touchUpInside)
        
        completeButton.setTitle("완료", for: .normal)
        completeButton.addTarget(self, action: #selector(completeButtonTouched), for: .touchUpInside)
    }
    
    private func createLayout() {
        safeArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safeArea)
        
        let guide = view.safeAreaLayoutGuide
        safeArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        safeArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        safeArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        view.addSubviews([titleView, cardView, saveButton, completeButton])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.horizontalEdges.equalToSuperview()
        }
        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.height.equalTo(cardView.snp.width).multipliedBy(1.3)
        }
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cardView.snp.bottom).offset(30)
            $0.width.equalTo(120)
            $0.height.equalTo(20)
        }
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(safeArea).inset(20)
        }
    }
    
}

// MARK: - Previews

struct ReviewCardVCPreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: ReviewCardViewController()).toPreview()
    }
    
}
