//
//  PaddingLabel.swift
//  DesignSystem
//
//  Created by 리아 on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

final public class PaddingLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 6.0, left: 10.0, bottom: 6.0, right: 10.0)

    convenience public init(padding: UIEdgeInsets? = nil) {
        self.init()
        if let padding = padding {
            self.padding = padding
        }
    }

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
    
}
