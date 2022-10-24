//
//  EvaluationViewController.swift
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

final class EvaluationViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let safeArea = UIView()
    private let titleView = MainTitleView(title: "요기쿠시동, 어땠나요?")
    private let evaluationStackView = UIStackView()
    private let goodButton = EvaluationButton(type: .good)
    private let sosoButton = EvaluationButton(type: .soso)
    private let badButton = EvaluationButton(type: .bad)

    // viewModel한테서 옵셔널로 받아올 거임
    // 사용자가 뒤로 갈 수도 있으니까
    private var evaluation: Evaluation!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc func goodButtonTouched() {
        goodButton.isSelected.toggle()
        sosoButton.isSelected = false
        badButton.isSelected = false
        
        evaluation = .good
        navigationController?.pushViewController(ReviewRegisterViewController(), animated: true)
    }
    
    @objc func sosoButtonTouched() {
        sosoButton.isSelected.toggle()
        badButton.isSelected = false
        goodButton.isSelected = false
        
        evaluation = .soso
        navigationController?.pushViewController(ReviewRegisterViewController(), animated: true)
    }
    
    @objc func badButtonTouched() {
        badButton.isSelected.toggle()
        goodButton.isSelected = false
        sosoButton.isSelected = false
        
        evaluation = .bad
        navigationController?.pushViewController(ReviewRegisterViewController(), animated: true)
    }
    
}

// MARK: - UI Function

extension EvaluationViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        evaluationStackView.axis = .horizontal
        evaluationStackView.spacing = 10
        evaluationStackView.distribution = .fillEqually
        
        goodButton.button.addTarget(self, action: #selector(goodButtonTouched), for: .touchUpInside)
        sosoButton.button.addTarget(self, action: #selector(sosoButtonTouched), for: .touchUpInside)
        badButton.button.addTarget(self, action: #selector(badButtonTouched), for: .touchUpInside)
    }
    
    private func createLayout() {
        safeArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safeArea)
        
        let guide = view.safeAreaLayoutGuide
        safeArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        safeArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        safeArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        view.addSubviews([titleView, evaluationStackView])
        evaluationStackView.addArrangedSubviews([goodButton, sosoButton, badButton])

        titleView.snp.makeConstraints {
            $0.top.leading.equalTo(safeArea)
            $0.width.equalTo(260)
        }
        evaluationStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(35)
            $0.height.equalTo(evaluationStackView.snp.width).multipliedBy(0.45)
        }
    }
    
}

// MARK: - Previews

struct EvaluationPreview: PreviewProvider {
    
    // TODO: previewDevice ZESTY_TEMPLATE에 추가하기
    
    static var previews: some View {
        UINavigationController(rootViewController: EvaluationViewController()).toPreview()
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
//            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
    }
    
}
