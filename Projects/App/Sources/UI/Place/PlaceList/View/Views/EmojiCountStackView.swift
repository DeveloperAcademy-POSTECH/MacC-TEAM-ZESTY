//
//  EmojiStackView.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class EmojiCountStackView: UIStackView {
    private let countLabel = UILabel()
    private let imageView = UIImageView()
    
    init(type: Evaluation, count: Int = 0) {
        super.init(frame: .zero)
        configureUI(type: type, count: count)
        createLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(count: Int) {
        countLabel.text = "\(count)"
    }
    
    private func configureUI(type: Evaluation, count: Int) {
        spacing = 5
        axis = .horizontal
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 13)
        imageView.image = type.image
        imageView.contentMode = .scaleAspectFit
    }
    
    private func createLayout() {
        addArrangedSubviews([imageView, countLabel])
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(30)
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
    
}
