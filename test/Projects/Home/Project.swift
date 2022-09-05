//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by choidam on 2022/08/23.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Home"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           platform: .iOS,
                                           iOSTargetVersion: iOSTargetVersion,
                                           infoPlist: infoPlist,
                                           dependencies: [
                                            .external(name: "SnapKit"),
                                            .external(name: "Then"),
                                            .external(name: "RxSwift"),
                                            .external(name: "RxCocoa"),
                                            .external(name: "ReactorKit"),
                                            .external(name: "Moya"),
                                            .external(name: "RxMoya"),
                                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI"))
                                           ])

