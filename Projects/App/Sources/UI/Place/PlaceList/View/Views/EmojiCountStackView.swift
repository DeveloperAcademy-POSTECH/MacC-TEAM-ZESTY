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
    
    init(emojiCount: Int, emoji: UIImage) {
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
    
    private func configureUI(emojiCount: Int, emoji: UIImage) {
        spacing = 5
        axis = .horizontal
        countLabel.text = String(emojiCount)
        countLabel.textColor = .white
        imageView.image = emoji
        imageView.contentMode = .scaleAspectFit
    }
    
    private func createLayout() {
        addArrangedSubviews([imageView, countLabel])
    }
}
