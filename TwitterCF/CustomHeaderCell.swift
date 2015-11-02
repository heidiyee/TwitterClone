//
//  CustomHeaderCell.swift
//  TwitterCF
//
//  Created by Heidi Yee on 11/1/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    
    var tweet: Tweet! {
        didSet {
            if let user = tweet.user {
                userName.text = user.name
                userScreenName.text = "@\(user.screenName)"
                if let url = NSURL(string: user.profileImageUrl) {
                    print(url)
                    
                    let imageData = NSData(contentsOfURL: url)!
                    let image = UIImage(data: imageData)
                    userImage.image = image
                }

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
