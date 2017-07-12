//
//  Comment.swift
//  DNApp
//
//  Created by Jorge Luiz on 14/05/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comment: NSObject {
    
    let id: String
    let body: String
    var voteCount: Int
    let bodyHTML: String
    let profile: Profile
    let createdAt : String
    let userPortraitUrl: String
    var isUpvoted: Bool = false
    
    init(jsonComment: JSON, profile: Profile) {
        self.profile = profile
        self.id = jsonComment["id"].string ?? ""
        self.body = jsonComment["body"].string ?? ""
        self.voteCount = jsonComment["links"]["comment_upvotes"].count
        self.bodyHTML = jsonComment["body_html"].string ?? ""
        self.createdAt = jsonComment["created_at"].string ?? ""
        self.userPortraitUrl = jsonComment["user_portrait_url"].string ?? ""
        
        let upvoteComments = jsonComment["links"]["comment_upvotes"].rawValue as? [String] ?? []
        let userUpvoteComments = LocalStore.getUserCommentsUpvotes()
        
        if(upvoteComments.count > 0 && userUpvoteComments.count > 0){
            self.isUpvoted = (Set(upvoteComments).intersection(Set(userUpvoteComments)).count > 0)
        }
    }
    
    public func addVote(upvoteId: String) {
        self.voteCount += 1
        self.isUpvoted = true
        LocalStore.addCommentUpvotes(upvoteId: upvoteId)
    }
    
    public func removeVote() {
        self.voteCount -= 1
        self.isUpvoted = false
    }
}
