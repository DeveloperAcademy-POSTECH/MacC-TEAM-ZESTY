//
//  EvaluationItemView.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit
import DesignSystem

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
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.text = "\(0)"
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: EvaluationViewModel) {
        DispatchQueue.main.async {
            
            self.countLabel.text = "\(viewModel.count)"
            
            switch viewModel.evaluation {
            case .good:
                self.imageView.image = UIImage(.img_reviewfriends_good)
            case .soso:
                self.imageView.image = UIImage(.img_reviewfriends_soso)
            case .bad:
                self.imageView.image = UIImage(.img_reviewfriends_bad)
            }
            
        }
    }
    
}

extension EvaluationItemView {
    
    // MARK: UI Function
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        self.addSubviews([countLabel, imageView])
        
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        countLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        
    }
}
