//
//  MediaViewController.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

import SimpleAuth

class MediaViewController: UITableViewController {
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hipstagram"
        
        tableView.registerClass(MediaCell.self, forCellReuseIdentifier: "media")
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        InstagramClient.sharedInstance().accessToken = userDefaults.objectForKey("accessToken") as? String
        
        if InstagramClient.sharedInstance().accessToken == nil {
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
        } else {
            print("Logged in.")
        }
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("media", forIndexPath: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.width
    }

}
