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
    
    let id: String
    let badge: String
    let title: String
    var voteCount: Int
    let storyUrl: String?
    var profile: Profile?
    var commentCount: Int
    let createdAt: String
    let commentsIds: [JSON]
    var isUpvoted: Bool = false
    
    init(story: JSON, profile: Profile?) {
        self.profile = profile
        self.id = story["id"].string ?? ""
        self.title = story["title"].string ?? ""
        self.badge = story["badge"].string ?? ""
        self.storyUrl = story["url"].string
        let userUpvotes = LocalStore.getUpvotes()
        self.voteCount = story["links"]["upvotes"].count
        self.createdAt = story["created_at"].string ?? ""
        self.commentCount = story["links"]["comments"].count
        self.commentsIds = story["links"]["comments"].array ?? []
        let storyUpvotes = story["links"]["upvotes"].rawValue as? [String] ?? []
        
        let hasUpvote = Set(storyUpvotes).intersection(Set(userUpvotes)).count > 0
        if hasUpvote {
            self.isUpvoted = true
        }
    }
    
    public func addUpvote(upvoteId: String) {
        self.voteCount += 1
        self.isUpvoted = true
        LocalStore.addStoryUpvotes(upvoteId: upvoteId)
    }
    
    public func removeUpvote() {
        self.voteCount -= 1
        self.isUpvoted = false
        LocalStore.updateStoryUpvotes()
    }
}
