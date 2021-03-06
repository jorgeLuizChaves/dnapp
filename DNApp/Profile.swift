//
//  Profile.swift
//  DNApp
//
//  Created by Jorge Luiz on 13/05/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON

class Profile: NSObject {
    
    let id: String
    let job: String
    let name: String
    let urlImageProfile: String
    
    init(userJSON: JSON){
        let id = userJSON[0]["id"].string ?? ""
        let job = userJSON[0]["job"].string ?? ""
        let name = userJSON[0]["display_name"].string ?? ""
        let portraitUrl = userJSON[0]["portrait_url"].string ?? ""
        
        self.id = id
        self.job = job
        self.name = name
        self.urlImageProfile = portraitUrl
    }
}
