//
//  Story.swift
//  DNApp
//
//  Created by Jorge Luiz on 13/05/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON

class Story: NSObject {
    
    let title: String
    let voteCount: Int
    let storyUrl: String
    var profile: Profile?
    let commentCount: Int
    let commentsIds: [JSON]
    let badge: String
    let createdAt: String
    
    init(story: JSON, profile: Profile?) {
        self.title = story["title"].string ?? ""
        self.voteCount = story["links"]["upvotes"].count 
        self.profile = profile
        self.storyUrl = story["title"].string ?? ""
        self.commentsIds = story["links"]["comments"].array ?? []
        self.badge = story["badge"].string ?? ""
        self.commentCount = story["links"]["comments"].count
        self.createdAt = story["created_at"].string ?? ""
    }

}
