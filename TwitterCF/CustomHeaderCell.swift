//
//  CustomHeaderCell.swift
//  TwitterCF
//
//  Created by Heidi Yee on 11/1/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    
    var tweet: Tweet! {
        didSet {
            if let user = tweet.user {
                userName.text = user.name
            }
        }
    }
    
    
    class func identifier() -> String {
        return "CustomHeaderCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
