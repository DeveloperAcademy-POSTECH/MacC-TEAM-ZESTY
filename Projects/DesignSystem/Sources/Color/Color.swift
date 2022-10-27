//
//  Color.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public enum Color: String {
    case background
    case disabled
    case dim
    case point
    case grayC5
    case grayF6
    case gray3C
    case gray3C3C43
    case gray54
    case whiteEBEBF5
    
    var hexString: String {
        switch self {
        case .background:
            return "#FFFFFFFF"
        case .disabled:
            return "#999999FF"
        case .dim:
            return "#545454FF"
        case .point:
            return "#EF4646FF"
        case .grayC5:
            return "#C5C5C5FF"
        case .grayF6:
            return "#F6F6F6FF"
        case .gray3C:
            return "#3C3C3CFF"
        case .gray54:
            return "#545454FF"
        case .gray3C3C43:
            return "#3C3C43FF"
        case .whiteEBEBF5:
            return "#EBEBF5FF"
        }
    }
}
