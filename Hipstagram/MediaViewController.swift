//
//  MediaViewController.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

import SimpleAuth

class MediaViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var media = [[String : AnyObject]]()
    
    var searchBar: UISearchBar?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hipstagram"
        
        tableView.registerClass(MediaCell.self, forCellReuseIdentifier: "media")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "loading")
        
        let searchBar = UISearchBar(frame: CGRectMake(0, 0, tableView.bounds.width, 44))
        searchBar.tintColor = UIColor(red: 0.90, green: 0.24, blue: 0.22, alpha: 1.0)
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        
        populateTableWithNewData()
        
    }
    
    // Fetch new data from Instagram and populate the table
    
    func populateTableWithNewData() {
        InstagramClient.sharedInstance().getRecentMedia { (media, errorString) -> Void in
            if let recentMedia = media {
                self.media += recentMedia
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
            }
            
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row < media.count {
            return mediaCellForIndexPath(indexPath)
        } else {
            populateTableWithNewData()
            return loadingCellForIndexPath(indexPath)
        }
    }
    
    func mediaCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("media", forIndexPath: indexPath) as! MediaCell
        
        cell.media = self.media[indexPath.row]
        
        return cell
    }
    
    func loadingCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("loading", forIndexPath: indexPath) 
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityIndicator.center = cell.center
        
        cell.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.width
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MediaCell
        
        let detailController = DetailViewController()
        if let image = cell.mediaImageView.image {
            detailController.imageData = UIImageJPEGRepresentation(image, 1.0)
        }
        
        presentViewController(detailController, animated: true, completion: nil)
    }
    
    // MARK: - Search bar delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        tableView.scrollEnabled = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        revertSearchBar(searchBar)
        populateTableWithNewData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        revertSearchBar(searchBar)
        
        guard let tag = searchBar.text else {
            return
        }
        
        InstagramClient.sharedInstance().getRecentMediaWithTag(tag) { (media, errorString) -> Void in
            if let recentMedia = media {
                self.media = recentMedia
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // Revert search bar to initial state
    func revertSearchBar(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
        tableView.scrollEnabled = true
    }

}
