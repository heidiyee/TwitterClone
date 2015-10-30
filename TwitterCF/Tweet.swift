//
//  Tweet.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/26/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class Tweet {
    
    let text: String
    let id: String
    var user: User?
    var retweetText: String?
    var retweetUser: User?
    var retweetBool: Bool?
    
    
    init(text: String, id: String, user: User? = nil, retweetText: String? = nil, retweetUser: User? = nil, retweetBool: Bool? = nil) {
        self.text = text
        self.id = id
        self.user = user
        self.retweetText = retweetText
        self.retweetUser = retweetUser
        self.retweetBool = retweetBool

        
    }
    
}
