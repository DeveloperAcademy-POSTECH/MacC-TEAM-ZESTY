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
    
    var textDidChangePublisher: AnyPublisher<UITextField, Never> { NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .eraseToAnyPublisher()
    }
    
    var textDidBeignEditingPublisher: AnyPublisher<UITextField, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .eraseToAnyPublisher()
    }
    
    var textDidEndEditingPublisher: AnyPublisher<UITextField, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .eraseToAnyPublisher()
    }
    
}
