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
    case gray8A8A8E
    
    var hexString: String {
        switch self {
        case .grayC5:
            return "#C5C5C5FF"
        case .gray8A8A8E:
            return "#8A8A8E"
        }
    }
}
