//
//  Constants.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 02/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

// MARK: InstagramClient (Constants)

extension InstagramClient {
    
    // MARK: Constants
    
    struct Constants {
        
        // MARK: API Keys
        static let ClientID = "358150b5ca1a41c38b0a99a47e6557a4" //"7e8ea64d19504cf79696d44fba7d1208"
        
        // MARK: Base URL
        static let BaseSecureURL = "https://api.instagram.com/v1/"
        
    }
    
    // MARK: Methods
    
    struct Methods {
        
        // MARK: Recent Media
        static let RecentMedia = "media/popular"
        
        // MARK: Search Tags
        static let TagSearch = "tags/{tag-name}/media/recent"
        
    }
    
    // MARK: URL Keys
    
    struct URLKeys {
        
        // MARK: Search Tags
        static let TagName = "tag-name"
        
    }
    
    // MARK: Parameter Keys
    
    struct ParameterKeys {
        
        // MARK: Required parameter
        static let ClientID = "client_id"
        static let AccessToken = "access_token"
        
        // MARK: Count
        static let Count = "count"
        
        // MARK: Minimum ID
        static let MinID = "min_id"
        
    }
    
}