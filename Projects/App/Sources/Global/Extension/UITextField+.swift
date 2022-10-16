//
//  UITextField.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> { NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }
    
}
