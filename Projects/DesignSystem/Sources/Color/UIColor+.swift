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
}
