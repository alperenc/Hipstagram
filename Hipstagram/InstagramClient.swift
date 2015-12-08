//
//  InstagramClient.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 02/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

class InstagramClient: NSObject {
    
    // MARK: Properties
    
    // Shared session
    var session: NSURLSession
    
    // User defaults
    let userDefaults : NSUserDefaults
    
    // Authentication
    var accessToken: String?
    
    // Minimum ID
    var minID: Int!
    
    // MARK: Initializers
    
    override init() {
        session = NSURLSession.sharedSession()
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        // Get access token and minimum id from user defaults
        
        if let token = userDefaults.objectForKey("accessToken") as? String {
            accessToken = token
        } else {
            accessToken = nil
        }
        
        if let minimum = userDefaults.objectForKey("minID") as? Int {
            minID = minimum
        } else {
            minID = 0
        }
        
        super.init()
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> InstagramClient {
        
        struct Singleton {
            static var sharedInstance = InstagramClient()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: GET
    
    func taskForGETMethod(method: String, parameters: [String: AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        // Build the URL and configure the request
        let urlString = Constants.BaseSecureURL + method + InstagramClient.escapedParameters(parameters)
        
        guard let url = NSURL(string: urlString) else {
            print("Unable to build the url.")
            return nil
        }
        
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            // Guard: Is there an error?
            guard (error == nil) else {
                print("Error with request")
                return
            }
            
            // Guard: Do we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            // Guard: Is there any data returned?
            guard let data = data else {
                print("No data returned")
                return
            }
            
            InstagramClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
        }
        
        // Start the task
        task.resume()
        
        return task
        
    }
    
    // MARK: Helpers
    
    // Given raw JSON, return a usable Foundation object */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandler(result: parsedResult, error: nil)
    }
    
    // Substitute the key for the value that is contained within the method name */
    class func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    // Given a dictionary of parameters, convert to a string for a url
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
}
