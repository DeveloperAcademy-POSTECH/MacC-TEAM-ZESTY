//
//  SceneDelegate.swift
//  ZestyManifests
//
//  Created by Lee Myeonghwan on 2022/10/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let userAuthToken = KeyChainManager.read(key: .authToken)
        let userNickName = UserInfoManager.userInfo?.userNickname
        let organizationID = UserInfoManager.userInfo?.userOrganization
        let navigationController = UINavigationController(rootViewController: ThirdPartyLoginViewController())
        // 로그인 했는데 닉네임 설정 안한경우
        if userAuthToken != nil && userNickName == nil {
            navigationController.pushViewController(NickNameInputViewController(state: .signup), animated: false)
        }
        // 로그인과 닉네임 설정 했는데 이메일 인증을 안한경우
        if userAuthToken != nil && userNickName != nil && organizationID == nil {
            navigationController.pushViewController(OrganizationListViewController(), animated: false)
        }
        // 정상적으로 가입을 한경우
        if userAuthToken != nil && userNickName != nil && organizationID != nil {
            navigationController.pushViewController(PlaceListViewController(), animated: false)
        }
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        /// remove navigation back button text and change color
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.topItem?.title = ""
    }
}
