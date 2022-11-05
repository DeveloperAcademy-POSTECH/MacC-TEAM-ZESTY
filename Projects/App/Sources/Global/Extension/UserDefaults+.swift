//
//  UserDefaults+.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private enum UserInfoKeys: String, CaseIterable {
        case authIdentifier
        case userNickname
        case userID
        case userOrganization
    }
    
    var authIdentifier: String? {
        get {
            guard let authIdentifier = UserDefaults.standard.value(forKey: UserInfoKeys.authIdentifier.rawValue) as? String else {
                return nil
            }
            return authIdentifier
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserInfoKeys.authIdentifier.rawValue)
        }
    }
    
    var userNickname: String? {
        get {
            guard let userName = UserDefaults.standard.value(forKey: UserInfoKeys.userNickname.rawValue) as? String else {
                return nil
            }
            return userName
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserInfoKeys.userNickname.rawValue)
        }
    }
    
    var userID: Int? {
        get {
            guard let userID = UserDefaults.standard.value(forKey: UserInfoKeys.userID.rawValue) as? Int else {
                return nil
            }
            return userID
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserInfoKeys.userID.rawValue)
        }
    }
    
    var userOrganization: Int? {
        get {
            guard let userOrganization = UserDefaults.standard.value(forKey: UserInfoKeys.userOrganization.rawValue) as? Int else {
                return nil
            }
            return userOrganization
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserInfoKeys.userOrganization.rawValue)
        }
    }
    
    func resetUserInfo() {
        UserInfoKeys.allCases.forEach { userInfoKeys in
            UserDefaults.standard.set(nil, forKey: userInfoKeys.rawValue)
        }
    }
    
}
