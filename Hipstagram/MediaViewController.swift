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
    
    // MARK: - Properties
    var media = [[String : AnyObject]]()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hipstagram"
        
        tableView.registerClass(MediaCell.self, forCellReuseIdentifier: "media")
        
        InstagramClient.sharedInstance().getRecentMedia { (media, errorString) -> Void in
            if let recentMedia = media {
                self.media = recentMedia
                print(self.media)
                print(self.media.count)
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.media.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("media", forIndexPath: indexPath) as! MediaCell
        
        cell.media = self.media[indexPath.row]

        return cell
    }
    
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.width
    }

}
