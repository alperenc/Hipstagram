//
//  MediaCell.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

import PureLayout

class MediaCell: UITableViewCell {
    
    //MARK: - Properties
    
    var mediaDownloadTask: NSURLSessionTask?
    var avatarDownloadTask: NSURLSessionTask?
    
    var media = [String: AnyObject]() {
        didSet {
            if let urlStringMedia = media["images"]?["standard_resolution"]??["url"] as? String,
                let url = NSURL(string: urlStringMedia) {
                    // If there's already a task started, cancel it.
                    if let task = self.mediaDownloadTask {
                        task.suspend()
                        task.cancel()
                    }
                    
                    self.mediaDownloadTask = InstagramClient.sharedInstance().getImageFromURL(url) { (image) in
                        self.mediaImageView.image = image
                    }
            }
            
            if let user = media["user"] as? [String: AnyObject] {
                if let urlStringAvatar = user["profile_picture"] as? String,
                    let url = NSURL(string: urlStringAvatar) {
                        // If there's already a task started, cancel it.
                        if let task = self.avatarDownloadTask {
                            task.suspend()
                            task.cancel()
                        }
                        
                        self.avatarDownloadTask = InstagramClient.sharedInstance().getImageFromURL(url) { (image) in
                            self.avatarImageView.image = image
                        }
                }
                
                if let username = user["username"] as? String {
                    usernameLabel.text = username
                }
            }
            
            if let createdAtString = media["created_time"] as? String,
                let createdAtDouble = Double(createdAtString) {
                    let createdAt = NSDate(timeIntervalSince1970: createdAtDouble).hipstagramDate()
                    timeLabel.text = createdAt
            }
            
        }
    }
    
    var mediaImageView : UIImageView!
    var avatarImageView : UIImageView!
    var usernameLabel : UILabel!
    var timeLabel : UILabel!
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        mediaImageView = UIImageView(frame: CGRectMake(0, 0, contentView.bounds.width, contentView.bounds.height))
        configureImageView(mediaImageView)
        
        avatarImageView = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        configureImageView(avatarImageView)
        
        usernameLabel = UILabel(frame: CGRectZero)
        usernameLabel.textAlignment = NSTextAlignment.Left
        
        timeLabel = UILabel(frame: CGRectZero)
        timeLabel.textAlignment = NSTextAlignment.Right
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(mediaImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        mediaImageView.image = nil
        avatarImageView.image = nil
    }
    
    // MARK: - Laying out subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.autoPinEdgeToSuperviewMargin(.Left)
        avatarImageView.autoPinEdgeToSuperviewMargin(.Top)
        avatarImageView.autoSetDimensionsToSize(CGSizeMake(30, 30))
        
        usernameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: avatarImageView, withOffset: 8.0)
        usernameLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: avatarImageView)
        
        timeLabel.autoPinEdgeToSuperviewMargin(.Right)
        timeLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: usernameLabel)
        
        mediaImageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        mediaImageView.autoPinEdge(.Top, toEdge: .Bottom, ofView: avatarImageView, withOffset: 8.0)
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2.0
        avatarImageView.layer.masksToBounds = true
        
    }
    
    // MARK: Configuring image views
    func configureImageView(imageView: UIImageView) {
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
    }
    
}
