//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by choidam on 2022/08/23.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "CommonUI"
private let iOSTargetVersion = "14.0"

let project = Project.framework(name: projectName,
                                platform: .iOS,
                                iOSTargetVersion: iOSTargetVersion,
                                dependencies: [])
