//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by choidam on 2022/08/23.
//

import ProjectDescription

let dependencies = Dependencies(
     swiftPackageManager: .init(
         [
            .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1")),
            .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
         ],
         productTypes: ["Then": .framework]
     ),
     platforms: [.iOS]
 )
