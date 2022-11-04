//
//  UIColor+.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public extension UIColor {
    class func zestyColor(_ color: Color) -> UIColor? {
        return UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil)
    }
    
    class func appearanceColor(light: Color, dark: Color) -> UIColor? {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return zestyColor(light)!
            case .dark:
                return zestyColor(dark)!
            @unknown default:
                return zestyColor(light)!
            }
        }
    }
}

// MARK: - Semantic Colors

public extension UIColor {
    
    // MARK: Background
    
    static let background = appearanceColor(light: .white, dark: .black)
    
    // MARK: Label
    
    static let reverseLabel = appearanceColor(light: .white, dark: .black)
    static let reverseSecondaryLabel = appearanceColor(light: .bluegray02, dark: .bluegray04)
    static let reverseTertiaryLabel = appearanceColor(light: .bluegray01, dark: .bluegray03)
    static let staticLabel = zestyColor(.white)
    static let staticSecondaryLabel = zestyColor(.bluegray02)
    
    // MARK: Common
    
    static let disabled = appearanceColor(light: .gray99, dark: .gray4A)
    static let dim = appearanceColor(light: .gray54, dark: .grayD0)
    static let point = zestyColor(.red01)
    static let shadow = appearanceColor(light: .black, dark: .clear)
    
    // MARK: Component
    
    static let blackComponent = appearanceColor(light: .black, dark: .white)
    static let grayComponent = appearanceColor(light: .grayF6, dark: .gray4A)
    static let codeInputEmpty = appearanceColor(light: .grayF6, dark: .gray4A)
    static let codeInputFill = appearanceColor(light: .black, dark: .white)
    static let cardFill = appearanceColor(light: .white, dark: .gray4A)
    static let mainListDescription = appearanceColor(light: .black, dark: .gray30)
    static let mainListEmptyBackground = appearanceColor(light: .grayF2, dark: .gray42)
    static let categoryLabelFill = appearanceColor(light: .black, dark: .gray4A)
    static let friendsSelection = appearanceColor(light: .black, dark: .grayD0)
}
