//
//  UIVIew+.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public extension UIView {
    
    // 뷰가 살짝 작았다가 커지는 효과
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                                        self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)},
                       completion: {  _ in
                                    UIView.animate(withDuration: 0.1,
                                                   delay: 0,
                                                   options: .curveLinear,
                                                   animations: { [weak self] in
                                        self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)},
                                                   completion: { [weak self] (_) in
                                        self?.isUserInteractionEnabled = true
                                        completionBlock()})}
        )}
    
}
