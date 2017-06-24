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
    let voteCount: Int
    let bodyHTML: String
    let profile: Profile
    let createdAt : String
    let userPortraitUrl: String
    
    init(jsonComment: JSON, profile: Profile) {
        self.profile = profile
        self.id = jsonComment["id"].string ?? ""
        self.body = jsonComment["body"].string ?? ""
        self.voteCount = jsonComment["comment_upvotes"].count
        self.bodyHTML = jsonComment["body_html"].string ?? ""
        self.createdAt = jsonComment["created_at"].string ?? ""
        self.userPortraitUrl = jsonComment["user_portrait_url"].string ?? ""
    }
}
