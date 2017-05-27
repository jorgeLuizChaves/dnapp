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
        case me
        case login
        case stories
        case user(userId: String)
        case storyId(storyId: Int)
        case storyReply(storyId: Int)
        case storyUpvote
        case commentReply(commentId: String)
        case comment(commentId: String)
        case commentUpvote(commentId: String)
        
        var description: String {
            switch self {
            case .me: return "/api/v2/me"
            case .login: return "/oauth/token"
            case .stories: return "/api/v2/stories"
            case .user(let id): return "/api/v2/users/\(id)"
            case .storyId(let id): return "/api/v2/stories/\(id)"
            case .comment(let id): return "/api/v2/comments/\(id)"
            case .storyReply(let id): return "/api/v2/stories/\(id)/reply"
            case .storyUpvote: return "/api/v2/upvotes"
            case .commentReply(let id): return "/api/v2/comments/\(id)/reply"
            case .commentUpvote(let id): return "/api/v2/comments/\(id)/upvote"
            }
        }
    }
    
    
    static func comment(byId commentId: String, completionHandler: @escaping (JSON) -> ()) {
        let urlString = baseURL + ResourcePath.comment(commentId: commentId).description
        Alamofire.request(urlString, method: .get, parameters: [:]).responseJSON { res in
            let comment = JSON(res.result.value ?? "")
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
    
    static func upvoteStoryWithId(_ story: Story, userId: String, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.storyUpvote.description
        upvoteWithUrlString(urlString, story: story,userId: userId, token: token, completion: completion)
    }
    
    static func me(byToken token: String, completionHandler: @escaping (JSON?) -> ()) {
        let urlString = "\(baseURL)\(ResourcePath.me.description)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        Alamofire.request(urlString, method: .get, headers: headers).responseJSON { response in
            let jsonUser = JSON(response.result.value ?? [])
            completionHandler(jsonUser["users"][0])
        }
        
    }
    
    private static func upvoteWithUrlString(_ urlString: String, story: Story, userId: String, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let url = URL(string: urlString)!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/vnd.api+json"
        ]
        
        let parameters = [
            "upvotes" : [
                "links" : ["story" : String(story.id), "user" : String(userId)]
            ]
        ]
                
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let successful = response.response?.statusCode == 201
            completion(successful)
        }
    }
}
