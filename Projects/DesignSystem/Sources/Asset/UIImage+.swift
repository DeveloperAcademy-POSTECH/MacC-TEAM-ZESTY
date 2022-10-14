//
//  UIImage+.swift
//  DesignSystem
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public extension UIImage {
    convenience init?(_ asset: Asset) {
        self.init(named: asset.rawValue, in: Bundle.module, with: nil)
    }

    convenience init?(assetName: String) {
        self.init(named: assetName, in: Bundle.module, with: nil)
    }
}
