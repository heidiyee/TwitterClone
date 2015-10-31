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

        
        self.tweetToDisplay()
        self.getImage()
    }
    
    func tweetToDisplay() {
        if tweet.retweetBool == true {
            tweetUser.text = self.tweet.retweetUser?.name
            detailedTweet.text = self.tweet.retweetText
        } else {
            tweetUser.text = self.tweet.user?.name
            detailedTweet.text = self.tweet.text
        }
        detailedTweet.preferredMaxLayoutWidth = 200
    }
    
    func getImage () {
        if let user = tweet.user {
            if let url = NSURL(string: user.profileImageUrl) {
                print(url)
            
                let imageData = NSData(contentsOfURL: url)!
                let image = UIImage(data: imageData)
                //tweet.user?.userImage = image
                userImage.setBackgroundImage(image, forState: .Normal)
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "UserTimelineViewControllerSegue" {

            if let listedViewController = segue.destinationViewController as? UserTimelineViewController {
                
                listedViewController.tweet = self.tweet

            }
        }
    }


}
