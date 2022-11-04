//
//  Font.swift
//  DesignSystem
//
//  Created by 민채호 on 2022/11/03.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit

public enum Font {
    
    public enum Size: CGFloat {
        case largeTitle = 26
        case title1 = 24
        case title2 = 22
        case title3 = 20
        case body = 17
        case callout = 16
        case footnote = 13
        case caption1 = 12
        case caption2 = 11
        case caption3 = 9
    }
    
    public enum Weight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
        
        var value: UIFont.Weight {
            switch self {
            case .ultraLight:
                return .ultraLight
            case .thin:
                return .thin
            case .light:
                return .light
            case .regular:
                return .regular
            case .medium:
                return .medium
            case .semibold:
                return .semibold
            case .bold:
                return .bold
            case .heavy:
                return .heavy
            case .black:
                return .black
            }
        }
    }
}
