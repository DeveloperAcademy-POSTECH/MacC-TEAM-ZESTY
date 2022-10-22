//
//  UserDefaults+.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var user: User? {
        get {
            guard let user = UserDefaults.standard.value(forKey: "User") as? User else {
                return nil
            }
            return user
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "User")
        }
    }
    
}
