//
//  CategoryTagLabel.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//
// ref: https://ios-development.tistory.com/698

import UIKit

public final class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
