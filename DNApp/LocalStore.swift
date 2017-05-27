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
    
    static func getUpvotes() -> [String] {
        if let upvotes  = userDefaults.array(forKey: upvotesKey) {
            return upvotes as! [String]
        }
        return []
    }
    
    static func deleteUpvotes() {
        userDefaults.removeObject(forKey: upvotesKey)
    }
    
    static func addStoryUpvotes(upvoteId: String){
        var elements = userDefaults.array(forKey: upvotesKey) as? [String] ?? []
        if(!elements.contains(upvoteId)){
            elements.append(upvoteId)
        }
    }
}
