//
//  NSDate+HipstagramDate.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 07/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import Foundation

extension NSDate {
    
    func hipstagramDate() -> String {
        let date : String
        
        let interval = -self.timeIntervalSinceNow
        
        if interval < 60 {
            date = "just now"
        } else if interval < (60 * 60) {
            date = "\(Int(floor(interval/60.0)))m"
        } else if interval < (60 * 60 * 24) {
            date = "\(Int(floor(interval/3600.0)))h"
        } else if interval < (60 * 60 * 24 * 7) {
            date = "\(Int(floor(interval/86400.0)))d"
        } else {
            date = "\(Int(floor(interval/604800.0)))w"
        }
        
        return date
    }
    
}