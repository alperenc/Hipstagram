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
        static let ClientID = "7e8ea64d19504cf79696d44fba7d1208"
        static let ClientSecret = "e465abd593c34213a855c01d811dbc57"
        
        // MARK: Base URL
        static let BaseSecureURL = "https://api.instagram.com/v1/"
        
    }
    
    // MARK: Methods
    
    struct Methods {
        
        // MARK: Recent Media
        static let RecentMedia = "users/self/media/recent"
        
        // MARK: Search Tags
        static let TagSearch = "tags/{tag-name}/media/recent"
        
        // MARK: Likes
        static let Likes = "media/{media-id}/likes"
        
    }
    
    // MARK: URL Keys
    
    struct URLKeys {
        
        // MARK: Search Tags
        static let TagName = "tag-name"
        
        // MARK: Likes
        static let MediaID = "media-id"
        
    }
    
    // MARK: Parameter Keys
    
    struct ParameterKeys {
        
        // MARK: Search Tags
        static let Q = "q"
        static let accessToken = "access_token"
        
    }
    
}