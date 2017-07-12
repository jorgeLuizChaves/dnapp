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
    
    let timeZoneFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    weak var delegate: CommentsTableViewCellDelegate?
    
    
    @IBOutlet weak var avatarImageView: AsyncImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var replyButton: SpringButton!

//    @IBOutlet weak var commentTextView: AutoTextView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func upvoteButtonDidTouch(_ sender: SpringButton) {
        sender.animation = "pop"
        sender.force = 1
        sender.animate()
        delegate?.commentTableViewCellDidTouchUpvote(self, sender: sender)
    }
    
    @IBAction func replyButtonDidTouch(_ sender: SpringButton) {
        
    }
    
    func configureWithComment(_ comment: Comment) {        
        let body = comment.body
        let userJob = comment.profile.job
        let createdAt = comment.createdAt
        let voteCount = comment.voteCount
        let userDisplayName = comment.profile.name
        
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = "\(userDisplayName), \(userJob)"
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: timeZoneFormat), numericDates: true)
        upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentLabel.text = body
        
        if(comment.isUpvoted){
            self.upvoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
        }else {
            self.upvoteButton.setImage(UIImage(named: "icon-upvote"), for: .normal)
        }
    }
    
    func upvoteComment(_ voteCount: Int) {
        self.upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        self.upvoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
    }
    
    func unlikeComment(_ voteCount: Int) {
        self.upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        self.upvoteButton.setImage(UIImage(named: "icon-upvote"), for: .normal)
    }
}


protocol CommentsTableViewCellDelegate: class {
    func commentTableViewCellDidTouchUpvote(_ cell: CommentsTableViewCell, sender: Any)
}
