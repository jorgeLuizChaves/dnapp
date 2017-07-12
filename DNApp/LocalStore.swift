//
//  LocalStore.swift
//  DNApp
//
//  Created by Jorge Luiz on 20/05/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON

struct LocalStore {

    private static let tokenKey = "tokenKey"
    private static let userIdKey = "userIdKey"
    private static let upvotesKey = "upvotesKey"
    private static let commentsUpvotes = "commentsUpvotes"
    
    static let userDefaults = UserDefaults.standard
    
    static func saveToken(_ token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }
    
    static func getToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
    
    static func saveUserId(_ id: String?) {
        userDefaults.set(id, forKey: userIdKey)
    }
    
    static func getUserId() -> String? {
        return userDefaults.string(forKey: userIdKey)
    }
    
    static func deleteUserId() {
        userDefaults.removeObject(forKey: userIdKey)
    }
    
    
    static func saveUpvotes(_ upvotes: [String]?) {
        userDefaults.set(upvotes, forKey: upvotesKey)
    }
    
    static func saveCommentUpvotes(_ upvotes: [String]?) {
        userDefaults.set(upvotes, forKey: commentsUpvotes)
    }
    
    static func getUpvotes() -> [String] {
        if let upvotes  = userDefaults.array(forKey: upvotesKey) {
            return upvotes as! [String]
        }
        return []
    }
    
    static func updateStoryUpvotes() {
        if let token =  LocalStore.getToken() {
            LocalStore.deleteUpvotes()
            DNService.me(byToken: token) { res in
                let upvotes = res?["links"]["upvotes"].rawValue as? [String]
                LocalStore.saveUpvotes(upvotes)
            }
        }
    }
    
    static func updateCommentUpvotes() {
        if let _ =  LocalStore.getToken() {
            LocalStore.deleteCommentUpvotes()
        }
    }
    
    static func saveCommentsUpvotes(_ upvotes: [String]?) {
        userDefaults.set(upvotes, forKey: commentsUpvotes)
    }
    
    static func getUserCommentsUpvotes() -> [String] {
        if let upvotes  = userDefaults.array(forKey: commentsUpvotes) {
            return upvotes as! [String]
        }
        return []
    }
    
    static func deleteUpvotes() {
        userDefaults.removeObject(forKey: upvotesKey)
    }
    
    static func deleteCommentUpvotes() {
        userDefaults.removeObject(forKey: commentsUpvotes)
    }
    
    static func addStoryUpvotes(upvoteId: String){
        var elements = getUpvotes()
        if(!elements.contains(upvoteId)){
            elements.append(upvoteId)
        }
    }
    
    static func addCommentUpvotes(upvoteId: String){
        var elements = getUserCommentsUpvotes()
        if(!elements.contains(upvoteId)){
            elements.append(upvoteId)
            deleteCommentUpvotes()
            saveCommentsUpvotes(elements)
        }
    }
}
