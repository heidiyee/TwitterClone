//
//  CustomTweetViewCell.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class CustomTweetViewCell: UITableViewCell {
    
    @IBOutlet weak var twitterText: UILabel!
    @IBOutlet weak var twitterImage: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            
            twitterText.text = tweet.text
            
            if let user = tweet.user {
                if let url = NSURL(string: user.profileImageUrl) {
                    print(url)
                    
                    let imageData = NSData(contentsOfURL: url)!
                    let image = UIImage(data: imageData)
                    twitterImage.image = image
                }
            }
        }
    }
    
    class func identifier() -> String {
        return "CustomTweetViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
