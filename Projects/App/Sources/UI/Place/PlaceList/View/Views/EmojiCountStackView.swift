//
//  EmojiStackView.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

class EmojiCountStackView: UIStackView {
    private let countLabel = UILabel()
    private let imageView = UIImageView()
    
    init(emojiCount: Int = 0, emoji: UIImage? = nil) {
        super.init(frame: .zero)
        configureUI(emojiCount: emojiCount, emoji: emoji)
        createLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(emojiCount: Int = 0, emoji: UIImage? = nil) {
        spacing = 2
        axis = .horizontal
        countLabel.text = String(emojiCount)
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 13)
        imageView.image = emoji
        imageView.contentMode = .scaleAspectFit
    }
    
    private func createLayout() {
        addArrangedSubviews([imageView, countLabel])
    }
}
