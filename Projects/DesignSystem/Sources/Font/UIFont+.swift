//
//  UIFont+.swift
//  DesignSystem
//
//  Created by 민채호 on 2022/11/03.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit

public extension UIFont {
    class func zestyFont(size: Font.Size, weight: Font.Weight) -> UIFont {
        return .systemFont(ofSize: size.rawValue, weight: weight.value)
    }
    
    // TODO: 폰트 시스템 적용 후 삭제 예정
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
