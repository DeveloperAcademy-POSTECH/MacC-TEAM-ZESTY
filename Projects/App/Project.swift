//
//  Project.swift
//  ZestyManifests
//
//  Created by Lee Myeonghwan on 2022/10/05.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "App",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Projcet.Network,
        .Projcet.DesignSystem,
        .external(name: "KakaoSDK"),
        .external(name: "SnapKit"),
        .external(name: "Kingfisher"),
        .external(name: "FirebaseAnalytics")
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Application/Info.plist"),
    entitlements: .relativeToCurrentFile("App.entitlements")
)
