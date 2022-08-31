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
            .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMajor(from: "3.2.0")),
            .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1")),
            .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxNimble.git", requirement: .upToNextMajor(from: "5.0.0")),
            .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
         ],
         productTypes: [
            "ReactorKit": .framework,
            "Then": .framework
         ]
     ),
     platforms: [.iOS]
 )
