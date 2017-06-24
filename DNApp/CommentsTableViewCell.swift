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
        
    }
    
    
    @IBAction func replyButtonDidTouch(_ sender: SpringButton) {
        
    }
    
    func configureWithComment(_ comment: Comment) {        
        let body = comment.body
        let bodyHTML = comment.bodyHTML
        let userJob = comment.profile.job
        let createdAt = comment.createdAt
        let voteCount = comment.voteCount
        let userDisplayName = comment.profile.name
        
//        commentTextView.attributedText = htmlToAttributedString(text:"\(bodyHTML)<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
        
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = "\(userDisplayName), \(userJob)"
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: timeZoneFormat), numericDates: true)
        upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentLabel.text = body
    }
}
