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
    
    let badge: String
    let title: String
    let voteCount: Int
    let storyUrl: String
    var profile: Profile?
    let commentCount: Int
    let createdAt: String
    let commentsIds: [JSON]
    
    init(story: JSON, profile: Profile?) {
        self.profile = profile
        self.title = story["title"].string ?? ""
        self.badge = story["badge"].string ?? ""
        self.storyUrl = story["title"].string ?? ""
        self.voteCount = story["links"]["upvotes"].count
        self.createdAt = story["created_at"].string ?? ""
        self.commentCount = story["links"]["comments"].count
        self.commentsIds = story["links"]["comments"].array ?? []
    }

}
