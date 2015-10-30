//
//  DetailViewController.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/28/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailedTweet: UILabel!
    @IBOutlet weak var tweetUser: UILabel!
    @IBOutlet weak var userImage: UIButton!
    
    var tweet: Tweet!

    
    class func identifier() -> String {
        return "DetailViewController"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedTweet.preferredMaxLayoutWidth = 200
        
        self.tweetToDisplay()
    }
    
    func tweetToDisplay() {
        if tweet.retweetBool == true {
            tweetUser.text = self.tweet.retweetUser?.name
            detailedTweet.text = self.tweet.retweetText
        } else {
            tweetUser.text = self.tweet.user?.name
            detailedTweet.text = self.tweet.text
        }
    }

}
