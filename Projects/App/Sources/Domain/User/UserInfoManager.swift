//
//  UserDefaults+.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/22.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation
import Combine
import Network

final class UserInfoManager {
    
    public static let shared = UserInfoManager()
    private var cancelBag = Set<AnyCancellable>()
    public var isNameFetched = PassthroughSubject<Bool, Never>()
    
    private enum UserInfoKeys: String, CaseIterable {
        case userNickname
        case userID
        case userOrganization
        case userOrgName
    }
    
    struct UserInfo: Codable {
        
        init(userNickname: String? = nil, userID: Int? = nil, userOrganization: [Int] = [], userOrgName: String? = nil ) {
            UserInfoManager.userInfo?.userNickname = userNickname
            UserInfoManager.userInfo?.userID = userID
            UserInfoManager.userInfo?.userOrganization = userOrganization
            UserInfoManager.userInfo?.userOrgName = userOrgName
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
        var userOrganization: [Int] {
            get {
                guard let userOrganization = UserDefaults.standard.value(forKey: UserInfoKeys.userOrganization.rawValue) as? [Int] else {
                    return []
                }
                return userOrganization
            }
            set {
                UserDefaults.standard.set(newValue, forKey: UserInfoKeys.userOrganization.rawValue)
            }
        }
        var userOrgName: String? {
            get {
                guard let userOrgName = UserDefaults.standard.value(forKey: UserInfoKeys.userOrgName.rawValue) as? String else {
                    return nil
                }
                return userOrgName
            }
            set {
                UserDefaults.standard.set(newValue, forKey: UserInfoKeys.userOrgName.rawValue)
            }
        }
    }
    
    static var userInfo: UserInfo? {
        get {
            if let userInfoData = UserDefaults.standard.value(forKey: "userInfo") as? Data {
                let decoder = JSONDecoder()
                if let userInfo = try? decoder.decode(UserInfo.self, from: userInfoData) {
                    return userInfo
                }
            }
            return nil
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
    
    static func initialUserInfo(userNickname: String?, userID: Int?, userOrganization: [Int], userOrgName: String?) {
        UserInfoManager.userInfo = UserInfo()
        UserInfoManager.userInfo?.userNickname = userNickname
        UserInfoManager.userInfo?.userID = userID
        UserInfoManager.userInfo?.userOrganization = userOrganization
        UserInfoManager.userInfo?.userOrgName = userOrgName
    }
    
}

extension UserInfoManager: ErrorMapper {
    
    // TODO: fetchOrganizationList 와 userOrgName 업데이트 분리
    func fetchOrganizationList(orgID: Int) {
        OrganizationAPI.fetchOrgList()
            .map { orgList in
                orgList.map { Organization(dto: $0) }
            }
            .eraseToAnyPublisher()
            .sink { [weak self] error in
                guard let self = self else { return }
                
                switch error {
                case .failure(let error):
                    let errorMessage = self.errorMessage(for: error)
                    print(errorMessage)
                case .finished: break
                }
            } receiveValue: { [weak self] orgList in
                UserInfoManager.userInfo?.userOrgName = orgList.first(where: {$0.id == orgID})?.name ?? "(인증대학없음)"
                self?.isNameFetched.send(true)
            }
            .store(in: &cancelBag)
    }
    
}
