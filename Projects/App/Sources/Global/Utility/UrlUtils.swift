//
//  openExternalLink.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/13.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

class UrlUtils {

    static func openExternalLink(urlStr: String, _ handler:(() -> Void)? = nil) {
        
        // 인코딩 -> 한글, 특수 문자 등 처리
        let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: encoded) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) { _ in
                handler?()
            }
            
        } else {
            UIApplication.shared.openURL(url)
            handler?()
        }
    }
}
