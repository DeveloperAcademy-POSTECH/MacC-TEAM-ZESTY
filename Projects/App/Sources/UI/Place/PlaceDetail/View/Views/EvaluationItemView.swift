//
//  EvaluationItemView.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

struct EvaluationViewModel {
    let evaluation: Evaluation
    let count: Int
}

class EvaluationItemView: UIView {
    
    private var viewModel: EvaluationViewModel?
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let countLabel: UILabel = {
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.text = "\(0)"
        return $0
    }(UILabel())
    
    private let titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 12)
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: EvaluationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        createLayout()
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: EvaluationViewModel) {
        countLabel.text = "\(viewModel.count)"
        
        switch viewModel.evaluation {
        case .good:
            titleLabel.text = "맛집"
            imageView.image = UIImage(.img_good)
        case .soso:
            titleLabel.text = "무난"
            imageView.image = UIImage(.img_soso)
        case .bad:
            titleLabel.text = "별로"
            imageView.image = UIImage(.img_bad)
        }
        
    }
    
}

extension EvaluationItemView {
    
    // MARK: UI Function
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        self.addSubviews([titleLabel, countLabel, imageView])
        self.bringSubviewToFront(countLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.centerX.equalTo(imageView.snp.centerX)
        }
        
    }
}
