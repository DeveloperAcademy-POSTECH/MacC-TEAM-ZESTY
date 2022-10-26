//
//  CALayer+.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright © 2022 zesty. All rights reserved.
//
// ref: https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur

import UIKit

extension CALayer {
  func applyFigmaShadow(
    color: UIColor = .black,
    opacity: Float = 0.25,
    xCoord: CGFloat = 0,
    yCoord: CGFloat = 0,
    blur: CGFloat = 5,
    spread: CGFloat = 0) {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = opacity
    shadowOffset = CGSize(width: xCoord, height: yCoord)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dxCoord = -spread
      let rect = bounds.insetBy(dx: dxCoord, dy: dxCoord)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
