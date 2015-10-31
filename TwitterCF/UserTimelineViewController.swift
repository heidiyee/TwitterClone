//
//  UserTimelineViewController.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {
    
    var tweet: Tweet!
    var tweets: [Tweet]!
    
    class func identifier() -> String {
        return "UserTimelineViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getStatus()
        
    }
    
    func getStatus() {
        if let user = tweet.user {
            TwitterTimeline.getUserStatusWithUserName(user.name, completion: { (error, tweets) -> () in
                if let error = error {
                    print(error); return
                }
                if let tweets = tweets {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.tweets = tweets
                    })
                }
            })
        }
    }

}
