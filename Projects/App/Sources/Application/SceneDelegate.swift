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
        let navigationController = UINavigationController(rootViewController: ThirdPartyLoginViewController())
        if userAuthToken != nil && userNickName != nil {
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
