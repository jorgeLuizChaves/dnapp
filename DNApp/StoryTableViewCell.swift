//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by Jorge Luiz on 26/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring
import SwiftyJSON

class StoryTableViewCell: UITableViewCell {
    
    let popAnimation = "pop"
    let forceIteraction = CGFloat(3)
    let timeZoneFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var commentButton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    @IBOutlet weak var profileImageView: AsyncImageView!
    
    weak var delegate: StoryTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWithStory(_ story: Story, isCommentEnable: Bool = true) {
        self.titleLabel.text = story.title
        self.authorLabel.text = story.profile?.name
        self.commentButton.isEnabled = isCommentEnable
        self.badgeImageView.image = UIImage(named: "badge-\(story.badge)")
        self.profileImageView.url = NSURL(string: story.profile?.urlImageProfile ?? "")
        self.profileImageView.placeholderImage = UIImage(named: "content-avatar-default")
        
        
        self.timeLabel.text = timeAgoSinceDate(date: dateFromString(date: story.createdAt, format: timeZoneFormat), numericDates: true)
        
        if(story.isUpvoted){
            self.upvoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
        }else {
            self.upvoteButton.setImage(UIImage(named: "icon-upvote"), for: .normal)
        }
        self.upvoteButton.setTitle(String(story.voteCount), for: UIControlState.normal)
        self.commentButton.setTitle(String(story.commentsIds.count), for: UIControlState.normal)
        
        
        if let commentTextView = commentTextView {
            commentTextView.text = String(story.commentsIds.count)
        }
    }
    
    @IBAction func upvoteButtonDidTouch(_ sender: Any) {
        configure(button: upvoteButton)
        delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)

    }
    
    @IBAction func commentButtonDidTouch(_ sender: Any) {
        configure(button: commentButton)
        delegate?.storyTableViewCellDidTouchComment(self, sender: sender)

    }
    
    private func configure(button: SpringButton) {
        button.animation = popAnimation
        button.force = forceIteraction
        button.animate()
    }
    
}

protocol StoryTableViewCellDelegate : class {
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: Any)
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: Any)
}
