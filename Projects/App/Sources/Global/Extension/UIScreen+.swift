//
//  UIScreen+.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

public extension UIScreen {
  /// - Mini, SE: 375.0
  /// - pro: 390.0
  /// - pro max: 428.0
  var isWiderThan425pt: Bool { self.bounds.size.width > 425 } // MAX
  var isLessThan376pt: Bool { self.bounds.size.width < 376 } // MINI
  var isHeightLessThan670pt: Bool { self.bounds.size.height < 670 }
}
