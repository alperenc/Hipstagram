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
        window?.rootViewController = navigationController
        
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        return true
    }

}

