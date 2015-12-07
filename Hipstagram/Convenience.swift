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
    
    func getRecentMedia(completionHandler: (media: [[String: AnyObject]]?, errorString: String?) -> Void) {
        
        // Specify method parameters
        let parameters: [String: AnyObject] = [ParameterKeys.ClientID: Constants.ClientID, ParameterKeys.MinID: self.minID]
        
        // Make the request
        self.taskForGETMethod(Methods.RecentMedia, parameters: parameters) { (result, error) -> Void in
            guard let mediaResult = result["data"] as? [[String: AnyObject]] else {
                completionHandler(media: nil, errorString: error?.localizedDescription)
                return
            }
            
            if let last = mediaResult.last, let minimum = last["id"] as? Int {
                self.minID = minimum
                
                self.userDefaults.setObject(minimum, forKey: "minID")
                self.userDefaults.synchronize()
            }
            
            completionHandler(media: mediaResult, errorString: nil)
        }
        
    }
    
    func getAccessToken(completionHandler: (accessToken: String?, errorString: String?) -> Void) {
        
        if accessToken != nil {
            completionHandler(accessToken: accessToken, errorString: nil)
            
        } else {
            
            // Authenticate with SimpleAuth
            SimpleAuth.authorize("instagram", options: ["scope": ["public_content", "likes"]]) { (responseObject, error) in
                
                guard let response = responseObject as? NSDictionary else {
                    print("Error receiving response!")
                    completionHandler(accessToken: nil, errorString: error.localizedDescription)
                    return
                }
                
                guard let token = response.valueForKeyPath("credentials.token") as? String else {
                        print("No such key: credentials")
                        completionHandler(accessToken: nil, errorString: error.localizedDescription)
                        return
                }
                
                self.accessToken = token
                
                self.userDefaults.setObject(token, forKey: "accessToken")
                self.userDefaults.synchronize()
                
                completionHandler(accessToken: token, errorString: nil)
            }
        }
    }
    
}