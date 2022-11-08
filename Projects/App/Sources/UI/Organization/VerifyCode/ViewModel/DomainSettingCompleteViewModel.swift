//
//  DomainSettingCompleteViewModel.swift
//  App
//
//  Created by 김태호 on 2022/11/08.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

final class DomainSettingCompleteViewModel {
    
    let userName = UserInfoManager.userInfo?.userNickname
    let orgName = UserInfoManager.userInfo?.userOrgName
    
}
