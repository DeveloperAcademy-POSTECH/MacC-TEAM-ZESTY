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
        // TODO: 로그아웃, 회원 탈퇴 기능 완성 시 주석 해제
//        let userAuthToken = UserDefaults.standard.authToken
//        let userNickName = UserDefaults.standard.userNickname
//        let navigationController: UINavigationController
//        if userAuthToken == nil && userNickName == nil {
//            navigationController = UINavigationController(rootViewController: ThirdPartyLoginViewController())
//        } else {
//            navigationController = UINavigationController(rootViewController: PlaceListViewController())
//        }
        let navigationController = UINavigationController(rootViewController: PlaceListViewController())
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        /// remove navigation back button text and change color
        
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.topItem?.title = ""
    }
}
