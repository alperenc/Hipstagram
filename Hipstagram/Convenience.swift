//
//  Convenience.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 02/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import Foundation

import SimpleAuth
import SAMCache

extension InstagramClient {
    
    func getRecentMedia(completionHandler: (media: [[String: AnyObject]]?, errorString: String?) -> Void) {
        
        // Specify method parameters
        let parameters: [String: AnyObject] = [ParameterKeys.ClientID: Constants.ClientID, ParameterKeys.MinID: self.minID]
        
        // Make the request
        taskForGETMethod(Methods.RecentMedia, parameters: parameters) { (result, error) -> Void in
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
    
    func getRecentMediaWithTag(tag: String, completionHandler: (media: [[String: AnyObject]]?, errorString: String?) -> Void) {
        
        getAccessToken { (accessToken, errorString) -> Void in
            
            guard let token = accessToken else {
                completionHandler(media: nil, errorString: errorString)
                return
            }
            
            // Specify method parameters and API method
            let parameters : [String: AnyObject] = [ParameterKeys.AccessToken: token, ParameterKeys.MinID: self.minID]
            
            if let apiMethod = InstagramClient.subtituteKeyInMethod(Methods.TagSearch, key: InstagramClient.URLKeys.TagName, value: tag) {
                
                // Make the request
                self.taskForGETMethod(apiMethod, parameters: parameters) { (result, error) -> Void in
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
                
            } else {
                completionHandler(media: nil, errorString: "Wrong API method")
                
            }
            
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
    
    func getImageFromURL(url: NSURL, completionHandler:(image: UIImage?) -> Void) -> NSURLSessionTask? {
        let key = "\(url)"
        let image = SAMCache.sharedCache().imageForKey(key)
        
        if image != nil {
            completionHandler(image: image)
            return nil
        }
        
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: url)
        
        let downloadTask = session.downloadTaskWithRequest(request) { (location, response, error) -> Void in
            
            guard let url = location,
                let imageData = NSData(contentsOfURL: url) else {
                    return
            }
            
            let image = UIImage(data: imageData)
            SAMCache.sharedCache().setImage(image, forKey: key)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completionHandler(image: image)
            })
        }
        
        downloadTask.resume()
        
        return downloadTask
    }
    
}