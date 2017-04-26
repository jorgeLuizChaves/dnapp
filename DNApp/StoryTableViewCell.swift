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
    
    
    @IBOutlet weak var badgeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!

    @IBOutlet weak var commentButton: SpringButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func upvoteButtonDidTouch(_ sender: Any) {
        upvoteButton.animation = "pop"
        upvoteButton.force = 3
        upvoteButton.animate()
    }
    
    @IBAction func commentButtonDidTouch(_ sender: Any) {
        commentButton.animation = "pop"
        commentButton.force = 3
        commentButton.animate()
    }
    
}
