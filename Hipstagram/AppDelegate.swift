//
//  AppDelegate.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

import SimpleAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        SimpleAuth.configuration()["instagram"] = [
            "client_id": "7e8ea64d19504cf79696d44fba7d1208",
            SimpleAuthRedirectURIKey: "hipstagram://auth/instagram"
        ]
        
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

