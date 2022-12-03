//
//  NavigationBar+.swift
//  App
//
//  Created by 리아 on 2022/11/04.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    static func setOpacityAppearance() {
        if #available(iOS 15, *) {
            // 네비게이션바 설정
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            // 네비게이션바 배경색
            appearance.backgroundColor = .background
            
            // 아래 회색 라인 없애기
            appearance.shadowColor = .clear
            
            Self.appearance().standardAppearance = appearance
            Self.appearance().scrollEdgeAppearance = appearance
        }
    }
    
}
