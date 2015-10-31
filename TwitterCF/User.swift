//
//  User.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/27/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class User {
    
    let name: String
    let profileImageUrl: String
    var userImage: UIImage?
    
    init(name: String, profileImageUrl: String) {
        self.name = name
        self.profileImageUrl = profileImageUrl
    }
}