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
    var tweet: Tweet!
    var user: User?
    
    class func identifier() -> String {
        return "DetailViewController"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailedTweet.text = self.tweet.text
        detailedTweet.preferredMaxLayoutWidth = 200
        //detailedTweet.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }

}
