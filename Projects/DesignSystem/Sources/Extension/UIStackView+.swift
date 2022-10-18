//
//  UIStackView+.swift
//  DesignSystem
//
//  Created by Lee Myeonghwan on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
}
