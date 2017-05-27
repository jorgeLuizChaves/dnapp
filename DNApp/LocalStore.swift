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
}


extension JSON: Hashable {
    public /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    var hashValue: Int {
        return 9
    }

    
    static func == (json1: JSON, json2: JSON) -> Bool {
        return json1.arrayValue == json2.arrayValue
    }
}
