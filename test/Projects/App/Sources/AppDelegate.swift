//
//  AppDelegate.swift
//  App
//
//  Created by choidam on 2022/08/23.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import CommonUI
import Home
import MyPage

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = MainTabBarController()
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.isTranslucent = false
        
        let homeVC = HomeViewController.create() ?? UIViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: CommonUIAsset.homeIcon.image, tag: 0)
        
        let mypageVC = MyPageViewController()
        mypageVC.tabBarItem = UITabBarItem(title: "MyPage", image: CommonUIAsset.mypageIcon.image, tag: 1)
        
        tabBarController.setViewControllers([homeVC, mypageVC], animated: false)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

