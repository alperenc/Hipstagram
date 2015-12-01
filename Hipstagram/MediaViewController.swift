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
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "media")
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("media", forIndexPath: indexPath)

        cell.backgroundColor = UIColor.lightGrayColor()

        return cell
    }

}
