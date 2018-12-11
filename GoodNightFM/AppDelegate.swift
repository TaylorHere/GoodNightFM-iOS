//
//  AppDelegate.swift
//  GoodNightFM
//
//  Created by 李彦宏
//  Copyright © 2018 李彦宏 All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationTabBar()
        return true
    }
}

extension AppDelegate {
    
    func setupNavigationTabBar() {
        //set Title Color here.
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "offWhite")!]
    }
}
