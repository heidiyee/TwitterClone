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
    var retweeted: Bool
    let retweetId: String
    var user: User?
    
    
    init(text: String, id: String, retweeted: Bool, retweetId: String, user: User? = nil) {
        self.text = text
        self.id = id
        self.retweeted = false
        self.retweetId = retweetId
        self.user = user
        
    }
    
}
