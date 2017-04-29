//
//  CommentsTableViewCell.swift
//  DNApp
//
//  Created by Jorge Luiz on 29/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring
import SwiftyJSON

class CommentsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var replyButton: SpringButton!

    @IBOutlet weak var commentTextView: AutoTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func upvoteButtonDidTouch(_ sender: SpringButton) {
        
    }
    
    
    @IBAction func replyButtonDidTouch(_ sender: SpringButton) {
    }
    
    func configureWithComment(_ comment: JSON) {
        let userPortraitUrl = comment["user_portrait_url"].string!
        let userDisplayName = comment["user_display_name"].string!
        let userJob = comment["user_job"].string!
        let createdAt = comment["created_at"].string!
        let voteCount = comment["vote_count"].int!
        let body = comment["body"].string!
        
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentTextView.text = body
    }
    

}
