//
//  Convenience.swift
//  Hipstagram
//
//  Created by Onur Candar on 02/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import Foundation

import SimpleAuth

extension InstagramClient {
    
    func getRecentMedia(completionHandler: (success: Bool, media: [[String: AnyObject]], errorString: String?) -> Void) {
        
        // Get access token from user defaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        guard let token = userDefaults.objectForKey("accessToken") as? String else {
            SimpleAuth.authorize("instagram", options: ["scope": ["public_content", "likes"]]) { (responseObject, error) in
                guard let response = responseObject as? [String: AnyObject] else {
                    print("Error receiving response!")
                    return
                }
                
                guard let credentials = response["credentials"] as? [String: AnyObject],
                    let token = credentials["token"] as? String else {
                        print("No such key: credentials")
                        return
                }
                
                print(response)
                
                userDefaults.setObject(token, forKey: "accessToken")
                userDefaults.synchronize()
                
            }
        }
        
        // Specify method parameters
        let parameters = [ParameterKeys.accessToken: token]
        
        // Make the request
        taskForGETMethod(Methods.RecentMedia, parameters: parameters) { (result, error) -> Void in
            <#code#>
        }
    }
    
}