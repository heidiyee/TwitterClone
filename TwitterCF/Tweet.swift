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
    
    init(text: String, id: String, user: User? = nil) {
        self.text = text
        self.id = id
        self.user = user
    }
    
}
