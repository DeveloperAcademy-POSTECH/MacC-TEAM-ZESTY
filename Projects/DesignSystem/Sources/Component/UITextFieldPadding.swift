//
//  UITextFieldPadding.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public final class UITextFieldPadding: UITextField {
    
    public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        padding = .init(top: top, left: left, bottom: bottom, right: right)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var padding: UIEdgeInsets

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
