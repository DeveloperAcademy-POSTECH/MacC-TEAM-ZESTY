//
//  UIFont+.swift
//  DesignSystem
//
//  Created by 리아 on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public extension UIFont {
    
    private func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
}
