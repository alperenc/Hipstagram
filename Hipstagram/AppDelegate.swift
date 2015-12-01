//
//  AppDelegate.swift
//  Hipstagram
//
//  Created by Onur Candar on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let mediaViewController = MediaViewController()
        let navigationController = UINavigationController(rootViewController: mediaViewController)
        
        let navigationBar = navigationController.navigationBar
        navigationBar.barTintColor = UIColor(red: 0.90, green: 0.24, blue: 0.22, alpha: 1.0)
        navigationBar.barStyle = UIBarStyle.BlackOpaque
        
        window?.rootViewController = navigationController
        
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        return true
    }

}

