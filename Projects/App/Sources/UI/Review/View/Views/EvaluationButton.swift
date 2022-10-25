//
//  EvaluationButton.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class EvaluationButton: UIView {

    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    @Published var isSelected = false

    private let backgroundView = UIView()
    private let evaluationStackView = UIStackView()
    private let evaluationIcon = UIImageView()
    private let evaluationLabel = UILabel()
    public let button = UIButton()
    
    // MARK: - LifeCycle
    
    public init(type: Evaluation) {
        super.init(frame: .zero)
        configureUI(type: type)
        createLayout()
        bind()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Binding

extension EvaluationButton {
        
    private func bind() {
        $isSelected
            .sink { [weak self] isSelected in
                guard let self = self else { return }
                self.backgroundView.backgroundColor = isSelected ? .black : .zestyColor(.grayF6)
                self.evaluationLabel.textColor = isSelected ? .white : .darkGray
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function

extension EvaluationButton {
    
    private func configureUI(type: Evaluation) {
        evaluationIcon.image = type.image
        evaluationLabel.text = type.desc
        evaluationLabel.textAlignment = .center
        evaluationLabel.font = .systemFont(ofSize: 13, weight: .medium)
        evaluationLabel.textColor = .darkGray
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        backgroundView.backgroundColor = .zestyColor(.grayF6)
        
        evaluationStackView.axis = .vertical
        evaluationStackView.spacing = 16
        evaluationStackView.distribution = .equalSpacing
    }
    
    private func createLayout() {
        addSubviews([backgroundView, evaluationStackView, button])
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        evaluationStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        evaluationStackView.addArrangedSubviews([evaluationIcon, evaluationLabel])
        evaluationIcon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(evaluationIcon.snp.width)
        }
        evaluationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(30)
            $0.height.equalTo(21)
        }
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

fileprivate extension Evaluation {
    
    var image: UIImage? {
        switch self {
        case .good:
            return UIImage(.img_reviewfriends_good)
        case .soso:
            return UIImage(.img_reviewfriends_soso)
        case .bad:
            return UIImage(.img_reviewfriends_bad)
        }
    }
    
    var desc: String {
        switch self {
        case .good:
            return "맛집이요"
        case .soso:
            return "무난했어요"
        case .bad:
            return "별로였어요"
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct EvaluationButtonPreview: PreviewProvider {
    
    static var previews: some View {
        EvaluationButton(type: .good).toPreview()
    }
    
}
#endif
