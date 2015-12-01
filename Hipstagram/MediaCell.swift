//
//  MediaCell.swift
//  Hipstagram
//
//  Created by Onur Candar on 01/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit
import PureLayout

class MediaCell: UITableViewCell {
    
    //MARK: - Properties
    
    let mediaImageView = UIImageView()
    let avatarImageView = UIImageView()
    let usernameLabel = UILabel()
    let timeLabel = UILabel()
    
    // MARK: - Initializers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        selectionStyle = UITableViewCellSelectionStyle.Gray
        clipsToBounds = false
        
        mediaImageView.image = UIImage(named: "image")
        avatarImageView.image = UIImage(named: "image")
        
        usernameLabel.text = "alperenc"
        usernameLabel.textAlignment = NSTextAlignment.Left
        
        timeLabel.text = "2d ago"
        timeLabel.textAlignment = NSTextAlignment.Right
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(mediaImageView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Laying out subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.autoPinEdgeToSuperviewMargin(.Left)
        avatarImageView.autoPinEdgeToSuperviewMargin(.Top)
        avatarImageView.autoSetDimensionsToSize(CGSizeMake(30, 30))
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2.0
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layoutIfNeeded()
        
        usernameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: avatarImageView, withOffset: 8.0)
        usernameLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: avatarImageView)
        
        timeLabel.autoPinEdgeToSuperviewMargin(.Right)
        timeLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: usernameLabel)
        
        mediaImageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        mediaImageView.autoPinEdge(.Top, toEdge: .Bottom, ofView: avatarImageView, withOffset: 8.0)
        
    }

}
