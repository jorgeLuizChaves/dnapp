//
//  DNService.swift
//  DNApp
//
//  Created by Jorge Luiz on 30/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire 

struct DNService {
    
    private static let baseURL = "https://www.designernews.co"
    private static let clientID = "750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d"
    private static let clientSecret = "53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"
    
    private enum ResourcePath: CustomStringConvertible {
        case login
        case stories
        case storyId(storyId: Int)
        case storyUpvote(storyId: Int)
        case storyReply(storyId: Int)
        case commentUpvote(commentId: Int)
        case commentReply(commentId: Int)
        
        var description: String {
            switch self {
            case .login: return "/oauth/token"
            case .stories: return "/api/v1/stories"
            case .storyId(let id): return "/api/v1/stories/\(id)"
            case .storyUpvote(let id): return "/api/v1/stories/\(id)/upvote"
            case .storyReply(let id): return "/api/v1/stories/\(id)/reply"
            case .commentUpvote(let id): return "/api/v1/comments/\(id)/upvote"
            case .commentReply(let id): return "/api/v1/comments/\(id)/reply"
            }
        }
    }
    
    static func storiesForSection(_ section: String, page: Int, completionHandler: @escaping (JSON) -> ()) {
        
        let urlString = baseURL + ResourcePath.stories.description + "/" + section
        let parameters = [
            "page": String(page),
            "client_id": clientID
        ]
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { response in
            let stories = JSON(response.result.value ?? [])
            completionHandler(stories)
        }
    }
}
