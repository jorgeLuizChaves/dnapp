//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by Jorge Luiz on 26/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class StoryTableViewCell: UITableViewCell {
    
    let timeZoneFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    
    @IBOutlet weak var badgeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!

    @IBOutlet weak var commentButton: SpringButton!
    
    weak var delegate: StoryTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureWithStory(_ story: AnyObject) {
        
        let title = story["title"] as! String
        let badge = story["badge"] as! String
        // let userPortraitUrl = story["user_portrait_url"] as! String
        let userDisplayName = story["user_display_name"] as! String
        let userJob = story["user_job"] as! String
        let createdAt = story["created_at"] as! String
        let voteCount = story["vote_count"] as! Int
        let commentCount = story["comment_count"] as! Int
        
        self.titleLabel.text = title
        self.badgeImageView.image = UIImage(named: "badge-" + badge)
        self.profileImageView.image = UIImage(named: "content-avatar-default")
        self.authorLabel.text = userDisplayName + ", " + userJob
        self.timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: timeZoneFormat), numericDates: true)
        
        self.upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        self.commentButton.setTitle(String(commentCount), for: UIControlState.normal)
    }
    
    
    @IBAction func upvoteButtonDidTouch(_ sender: Any) {
        upvoteButton.animation = "pop"
        upvoteButton.force = 3
        upvoteButton.animate()
        delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)

    }
    
    @IBAction func commentButtonDidTouch(_ sender: Any) {
        commentButton.animation = "pop"
        commentButton.force = 3
        commentButton.animate()
        delegate?.storyTableViewCellDidTouchComment(self, sender: sender)

    }
    
}

protocol StoryTableViewCellDelegate : class {
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: Any)
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: Any)
}
