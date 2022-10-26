//
//  UserDefaults+.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var authToken: String? {
        get {
            guard let authToken = UserDefaults.standard.value(forKey: "authToken") as? String else {
                return nil
            }
            return authToken
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "authToken")
        }
    }
    
    var userName: String? {
        get {
            guard let userName = UserDefaults.standard.value(forKey: "userName") as? String else {
                return nil
            }
            return userName
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }
    
    var userID: Int? {
        get {
            guard let userID = UserDefaults.standard.value(forKey: "userID") as? Int else {
                return nil
            }
            return userID
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userID")
        }
    }
    
}
