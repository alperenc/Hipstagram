//
//  MediaViewController.swift
//  Hipstagram
//
//  Created by Onur Candar on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

class MediaViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hipstagram"
        
        tableView.registerClass(MediaCell.self, forCellReuseIdentifier: "media")
        
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
