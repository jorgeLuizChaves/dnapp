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
    
    private static let grantType = "password"
    private static let baseURL = "https://www.designernews.co"
    private static let clientID = "750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d"
    private static let clientSecret = "53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"
    
    private enum ResourcePath: CustomStringConvertible {
        case login
        case stories
        case user(userId: String)
        case storyId(storyId: Int)
        case storyReply(storyId: Int)
        case storyUpvote(storyId: Int)
        case commentReply(commentId: Int)
        case comment(commentId: String)
        case commentUpvote(commentId: Int)
        
        var description: String {
            switch self {
            case .login: return "/oauth/token"
            case .stories: return "/api/v2/stories"
            case .user(let id): return "/api/v2/users/\(id)"
            case .storyId(let id): return "/api/v2/stories/\(id)"
            case .comment(let id): return "/api/v2/comments/\(id)"
            case .storyReply(let id): return "/api/v2/stories/\(id)/reply"
            case .storyUpvote(let id): return "/api/v2/stories/\(id)/upvote"
            case .commentReply(let id): return "/api/v2/comments/\(id)/reply"
            case .commentUpvote(let id): return "/api/v2/comments/\(id)/upvote"
            }
        }
    }
    
    static func comment(byId commentId: String, completionHandler: @escaping (JSON) -> ()) {
        let urlString = baseURL + ResourcePath.comment(commentId: commentId).description
        Alamofire.request(urlString, method: .get, parameters: [:]).responseJSON { res in
            let comment = JSON(res.result.value ?? "")
            print(comment)
            completionHandler(comment)
        }

    }
    
    static func storiesForSection(_ section: String, page: Int, completionHandler: @escaping (JSON) -> ()) {
        
        let urlString = "\(baseURL)\(ResourcePath.stories.description)/\(section)"
        let parameters = [
            "page": String(page),
            "client_id": clientID
        ]
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { response in
            let stories = JSON(response.result.value ?? [])
            completionHandler(stories)
        }
    }
    
    
    static func profile(byId userId: String, completionHandler: @escaping (JSON) -> ()) {
        let urlString = "\(baseURL)\(ResourcePath.user(userId: userId).description)"
        
        Alamofire.request(urlString, method: .get, parameters: [:]).responseJSON { response in
            let user = JSON(response.result.value ?? [])
            completionHandler(user)
        }
    }
    
    static func loginWithEmail(login: String, password: String, completionHandler: @escaping (String?) -> ()) {
        let urlString = "\(baseURL)\(ResourcePath.login.description)"
        
        let parameters = [
        "grant_type": grantType,
        "username": login,
        "password": password
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            let auth = JSON(response.result.value ?? [])
            completionHandler(auth["access_token"].string)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
