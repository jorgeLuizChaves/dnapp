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
    
    let urlImageProfile: String
    let name: String
    let job: String
    
    init(userJSON: JSON){
        let name = userJSON[0]["display_name"].string ?? ""
        let job = userJSON[0]["job"].string ?? ""
        let portraitUrl = userJSON[0]["portrait_url"].string ?? ""
        
        self.urlImageProfile = portraitUrl
        self.name = name
        self.job = job
    }
    

}
