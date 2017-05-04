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
    
    
    @IBOutlet weak var avatarImageView: AsyncImageView!
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
        print(comment.string ?? "no data")
        let userPortraitUrl = comment["user_portrait_url"].string ?? ""
        let userDisplayName = comment["user_display_name"].string ?? ""
        let userJob = comment["user_job"].string ?? ""
        let createdAt = comment["created_at"].string ?? ""
        let voteCount = comment["comment_upvotes"].count
        let body = comment["body"].string ?? ""
        let bodyHTML = comment["body_html"].string ?? ""
        
        
//        self.avatarImageView.url = userPortraitUrl.toURL() ?? NSURL(string: "")
//        self.avatarImageView.placeholderImage = UIImage(named: "content-avatar-default")
        
        commentTextView.attributedText = htmlToAttributedString(text: bodyHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
        
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentTextView.text = body
    }
    

}
