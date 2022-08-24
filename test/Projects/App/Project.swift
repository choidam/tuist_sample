//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by choidam on 2022/08/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "App"
private let iOSTargetVersion = "14.0"

let infoPlistPath: String = "Resources/App.plist"

let project = Project.app(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          infoPlist: infoPlistPath,
                          dependencies: [
                            .external(name: "SnapKit"),
                            .external(name: "Then"),
                            .project(target: "Home", path: .relativeToCurrentFile("../Home")),
                            .project(target: "MyPage", path: .relativeToCurrentFile("../MyPage")),
                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI"))
                          ])
