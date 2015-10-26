//
//  Tweet.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/26/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import Foundation

class Tweet {
    
    let text: String
    let id: String
    let favorites: Int
    let username: String
    let profileImageURL: String
    
    init(text: String, id: String, favorites: Int, username: String, profileImageURL: String) {
        self.text = text
        self.id = id
        self.favorites = favorites
        self.username = username
        self.profileImageURL = profileImageURL
    }
    
}
