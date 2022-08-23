//
//  AppDelegate.swift
//  MyPage
//
//  Created by choidam on 2022/08/23.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MyPageViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}

