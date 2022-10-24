//
//  ReviewCardViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class ReviewCardViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let safeArea = UIView()
    private let titleView = MainTitleView(title: "리뷰 등록 완료 🎉")
    private var cardView: ReviewCardView!
    private let saveButton = UIButton()
    private let completeButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc func backButtonTouched() {
        popTo(EvaluationViewController.self)
    }

    @objc func saveButtonTouched() {
        popTo(EvaluationViewController.self)
    }
    
    @objc func completeButtonTouched() {
        popTo(EvaluationViewController.self)
    }
    
    private func popTo<T>(_ viewController: T.Type) {
        let targetVC = navigationController?.viewControllers.filter { $0 is T }
        if let targetVC = targetVC, !targetVC.isEmpty {
            navigationController?.popToViewController(targetVC[0], animated: true)
        }
    }
    
}

// MARK: - UI Function

extension ReviewCardViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
        
        let xmarkConfig = UIImage.SymbolConfiguration(weight: .bold)
        let backImage = UIImage(systemName: "xmark", withConfiguration: xmarkConfig)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTouched))
        navigationItem.leftBarButtonItem = backButton
        
        cardView = ReviewCardView(image: UIImage(.img_mockmenu))
        
        let config = UIImage.SymbolConfiguration(paletteColors: [.red])
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

#if DEBUG
import SwiftUI

struct ReviewCardVCPreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: ReviewCardViewController()).toPreview()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
//            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
    }
    
}
#endif
