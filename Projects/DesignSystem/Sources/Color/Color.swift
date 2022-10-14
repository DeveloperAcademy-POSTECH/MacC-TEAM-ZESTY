//
//  Color.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public enum Color: String {
    case grayC5

    var hexString: String {
        switch self {
        case .grayC5:
            return "#C5C5C5FF"
        }
    }
}
