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
<<<<<<< HEAD
    case grayF6
    
=======
    case gray3C3C43

>>>>>>> 21265d5 (Feat✨: 장소상세정보 UI)
    var hexString: String {
        switch self {
        case .grayC5:
            return "#C5C5C5FF"
<<<<<<< HEAD
        case .grayF6:
            return "#F6F6F6"
=======
        case .gray3C3C43:
            return "#3C3C43FF"
>>>>>>> 21265d5 (Feat✨: 장소상세정보 UI)
        }
    }
}
