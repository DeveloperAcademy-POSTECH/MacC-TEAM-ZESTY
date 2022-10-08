//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2022/10/07.
//

import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
    static let DesignSystem = TargetDependency.project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
}
