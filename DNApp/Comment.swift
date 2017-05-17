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
    
    let body: String
    let profile: Profile
    let bodyHTML: String
    let voteCount: Int
    let createdAt : String
    let userPortraitUrl: String
    
    init(jsonComment: JSON, profile: Profile) {
        self.body = jsonComment["body"].string ?? ""
        self.bodyHTML = jsonComment["body_html"].string ?? ""
        self.voteCount = jsonComment["comment_upvotes"].count
        self.createdAt = jsonComment["created_at"].string ?? ""
        self.profile = profile
        self.userPortraitUrl = jsonComment["user_portrait_url"].string ?? ""
    }
}
