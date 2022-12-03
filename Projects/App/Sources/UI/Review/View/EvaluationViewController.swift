//
//  EvaluationViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import Firebase
import SnapKit

final class EvaluationViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let viewModel: ReviewRegisterViewModel
    
    private let titleView = MainTitleView()
    private let evaluationStackView = UIStackView()
    private let goodButton = EvaluationButton(type: .good)
    private let sosoButton = EvaluationButton(type: .soso)
    private let badButton = EvaluationButton(type: .bad)
    
    // MARK: - LifeCycle
    
    init(viewModel: ReviewRegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        analytics()
    }
    
    // MARK: - Function
    
    @objc private func goodButtonTouched() {
        goodButton.isSelected = true
        sosoButton.isSelected = false
        badButton.isSelected = false
        
        viewModel.evaluation = .good
        navigationController?.pushViewController(ReviewRegisterViewController(viewModel: viewModel), animated: true)
    }
    
    @objc private func sosoButtonTouched() {
        sosoButton.isSelected = true
        badButton.isSelected = false
        goodButton.isSelected = false
        
        viewModel.evaluation = .soso
        navigationController?.pushViewController(ReviewRegisterViewController(viewModel: viewModel), animated: true)
    }
    
    @objc private func badButtonTouched() {
        badButton.isSelected = true
        goodButton.isSelected = false
        sosoButton.isSelected = false
        
        viewModel.evaluation = .bad
        navigationController?.pushViewController(ReviewRegisterViewController(viewModel: viewModel), animated: true)
    }
    
    private func analytics() {
        FirebaseAnalytics.Analytics.logEvent("evaluation_viewed", parameters: [
            AnalyticsParameterScreenName: "evaluation"
        ])
    }
    
}

// MARK: - UI Function

extension EvaluationViewController {
    
    private func configureUI() {
        view.backgroundColor = .background
        navigationController?.navigationBar.topItem?.title = ""
        
        titleView.titleLabel.text = "\(viewModel.placeName),\n어땠나요?"
        
        evaluationStackView.axis = .horizontal
        evaluationStackView.spacing = 15
        evaluationStackView.distribution = .equalSpacing
        
        goodButton.button.addTarget(self, action: #selector(goodButtonTouched), for: .touchUpInside)
        sosoButton.button.addTarget(self, action: #selector(sosoButtonTouched), for: .touchUpInside)
        badButton.button.addTarget(self, action: #selector(badButtonTouched), for: .touchUpInside)
    }
    
    private func createLayout() {
        view.addSubviews([titleView, evaluationStackView])
        evaluationStackView.addArrangedSubviews([goodButton, sosoButton, badButton])

        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.width.equalTo(260)
        }
        evaluationStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct EvaluationPreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: EvaluationViewController(viewModel: ReviewRegisterViewModel(placeId: 1, placeName: "요기쿠시동"))).toPreview()
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
    
}
#endif
