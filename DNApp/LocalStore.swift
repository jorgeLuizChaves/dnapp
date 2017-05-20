//
//  LocalStore.swift
//  DNApp
//
//  Created by Jorge Luiz on 20/05/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit

struct LocalStore {

    static let userDefaults = UserDefaults.standard
    private static let tokenKey = "tokenKey"
    
    static func saveToken(_ token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }
    
    static func getToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
    
}
