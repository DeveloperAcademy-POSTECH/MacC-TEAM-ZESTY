//
//  keyChainManager.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/11/05.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation
import Security

final class KeyChainManager {
    
    enum Keys: String {
        case authToken
    }

    static func create(key: Keys, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,   // 저장할 Account
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any   // 저장할 Token
        ]
        SecItemDelete(query)    // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    static func read(key: Keys) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    static func delete(key: Keys) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}
