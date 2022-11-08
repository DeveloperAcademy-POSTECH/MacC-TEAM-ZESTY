//
//  UserDefaults+.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

final class UserInfoManager {
    
    private enum UserInfoKeys: String, CaseIterable {
        case userNickname
        case userID
        case userOrganization
    }
    
    struct UserInfo: Codable {
        
        init(userNickname: String? = nil, userID: Int? = nil, userOrganization: Int? = nil) {
            UserInfoManager.userInfo.userNickname = userNickname
            UserInfoManager.userInfo.userID = userID
            UserInfoManager.userInfo.userOrganization = userOrganization
        }
        
        var userNickname: String? {
            get {
                guard let userNickname = UserDefaults.standard.value(forKey: UserInfoKeys.userNickname.rawValue) as? String else {
                    return nil
                }
                return userNickname
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
    }
    
    static var userInfo: UserInfo {
        get {
            if let userInfoData = UserDefaults.standard.value(forKey: "userInfo") as? Data {
                let decoder = JSONDecoder()
                if let userInfo = try? decoder.decode(UserInfo.self, from: userInfoData) {
                    return userInfo
                }
            }
            return UserInfo()
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "userInfo")
            }
        }
    }
    
    static func resetUserInfo() {
        UserInfoManager.userInfo = UserInfo()
    }
    
}
