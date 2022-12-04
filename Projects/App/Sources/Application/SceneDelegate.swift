//
//  SceneDelegate.swift
//  ZestyManifests
//
//  Created by Lee Myeonghwan on 2022/10/05.
//

import Combine
import UIKit
import DesignSystem
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var now: Date?
    static let timeIntervalSubject = PassthroughSubject <Int, Never>()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let userAuthToken = KeyChainManager.read(key: .authToken)
        let userNickName = UserInfoManager.userInfo?.userNickname
        let isEmptyOrganization = UserInfoManager.userInfo?.userOrganization.isEmpty
        let navigationController = UINavigationController(rootViewController: ThirdPartyLoginViewController())
        // 정상적으로 가입을 한경우
        if userAuthToken != nil && userNickName != nil && isEmptyOrganization == false {
            navigationController.pushViewController(PlaceListViewController(), animated: false)
        }
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        /// remove navigation back button text and change color
        navigationController.navigationBar.tintColor = .accent
        navigationController.navigationBar.topItem?.title = ""
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        now = Date()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let now = self.now else { return }
        let timeInterval = Date().timeIntervalSince(now)
        SceneDelegate.timeIntervalSubject.send(Int(timeInterval))
    }
    
}
