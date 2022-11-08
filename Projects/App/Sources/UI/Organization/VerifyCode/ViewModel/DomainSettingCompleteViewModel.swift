//
//  DomainSettingCompleteViewModel.swift
//  App
//
//  Created by 김태호 on 2022/11/08.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

final class DomainSettingCompleteViewModel {
    // TODO: UserInfoManager로 변경하기
    let userName = UserDefaults.standard.userName ?? "김한국"
    let orgName = UserDefaults.standard.value(forKey: "orgName") as? String ?? "한국외국어대학교\n캠퍼스"
}
