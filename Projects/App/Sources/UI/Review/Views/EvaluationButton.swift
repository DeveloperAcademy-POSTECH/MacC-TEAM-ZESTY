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
    
    enum EvaluationType {
        case good
        case soso
        case bad
        
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
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    @Published var isSelected = false

    private let backgroundView = UIView()
    private let evaluationStackView = UIStackView()
    private let evaluationIcon = UIImageView()
    private let evaluationLabel = UILabel()
    public let button = UIButton()
    
    // MARK: - LifeCycle
    
    public init(type: EvaluationType) {
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
    
    private func configureUI(type: EvaluationType) {
        evaluationIcon.image = type.image
        evaluationIcon.contentMode = .scaleAspectFit
        
        evaluationLabel.text = type.desc
        evaluationLabel.textAlignment = .center
        evaluationLabel.font = .systemFont(ofSize: 13, weight: .medium)
        evaluationLabel.textColor = .darkGray
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        backgroundView.backgroundColor = .zestyColor(.grayF6)
        
        evaluationStackView.axis = .vertical
        evaluationStackView.spacing = 10
        evaluationStackView.distribution = .equalSpacing
    }
    
    private func createLayout() {
        addSubviews([backgroundView, evaluationStackView, button])
        
        snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(128)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        evaluationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        evaluationStackView.addArrangedSubviews([evaluationIcon, evaluationLabel])
        evaluationIcon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        evaluationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
