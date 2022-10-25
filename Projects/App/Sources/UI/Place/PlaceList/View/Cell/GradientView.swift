//
//  GradientView.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

// 출처 : https://stackoverflow.com/questions/39572990/applying-gradient-background-for-uiview-using-auto-layout=

final class GradientView: UIView {
    private let gradient: CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor

    init(gradientStartColor: UIColor, gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
