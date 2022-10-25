//
//  ReviewCardViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import Photos
import UIKit
import DesignSystem
import SnapKit

final class ReviewCardViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let titleView = MainTitleView()
    private var cardView: ReviewCardView!
    private let saveButton = UIButton()
    private let completeButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    init(viewModel: ReviewRegisterViewModel) {
        cardView = ReviewCardView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
}
    // MARK: - Function
 
extension ReviewCardViewController {

    @objc func backButtonTouched() {
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
    
    // TODO: Toast - noti image save completion
    @objc func saveButtonTouched() {
        let reviewCard = cardView.transfromToImage() ?? UIImage()
        saveImage(with: reviewCard)
    }
    
    func saveImage(with image: UIImage) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            guard status == .authorized else { return }
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: nil)
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
        
        titleView.titleLabel.text = "리뷰 등록 완료 🎉"
        
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
        view.addSubviews([titleView, cardView, saveButton, completeButton])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
        }
        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.height.equalTo(cardView.snp.width).multipliedBy(1.3)
        }
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cardView.snp.bottom).offset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(20)
        }
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ReviewCardVCPreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: ReviewCardViewController(viewModel: ReviewRegisterViewModel(placeId: 0, placeName: "요기쿠시동"))).toPreview()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
//            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
    }
    
}
#endif
