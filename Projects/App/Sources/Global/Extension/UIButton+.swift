//
//  UIButton+.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
    
}
