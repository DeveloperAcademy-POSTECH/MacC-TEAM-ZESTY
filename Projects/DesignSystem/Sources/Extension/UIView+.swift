//
//  UIView+.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
}

// MARK: - Animation

public extension UIView {
    
    func willHide(with duration: CGFloat) {
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            self.alpha = 0
        } completion: { _ in
            self.alpha = 1
            self.isHidden = true
        }
    }

    func willShow(with duration: CGFloat) {
        self.isHidden = false
        self.alpha = 0
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            self.alpha = 1
        } completion: { _ in
        }
    }
    
}
