//
//  ViewController+Extension.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func makeViewCircular(view: UIView) {
        view.layer.cornerRadius = view.bounds.size.width / 2.0
        view.clipsToBounds = true
    }
    
}
