//
//  UserTimelineViewController.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    
    var tweet: Tweet!
    var statusTweets = [Tweet]()
    
    class func identifier() -> String {
        return "UserTimelineViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getStatus()
        self.setUpViewController()
        

    }
    
    func setUpViewController() {
        self.tableView.estimatedRowHeight = 2
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let customTweetCellXib = UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomTweetViewCell.identifier())

    }
    
    func getStatus() {
        if let user = self.tweet.user {
            TwitterTimeline.getUserStatusFromScreenName(user.screenName) { (error, tweets) -> () in
                if let error = error {
                    print(error); return
                }
                if let tweets = tweets {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.statusTweets = tweets
                        self.tableView.reloadData()
                    })
                    
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.statusTweets.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomTweetViewCell.identifier(), forIndexPath: indexPath) as! CustomTweetViewCell
            print(statusTweets)
            print(self.statusTweets[indexPath.row])
            cell.tweet = self.statusTweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailedViewController = self.storyboard?.instantiateViewControllerWithIdentifier(UserTimelineViewController.identifier()) as! UserTimelineViewController
        detailedViewController.tweet = self.statusTweets[indexPath.row]
        self.navigationController?.pushViewController(detailedViewController, animated: true)
        
    }

}
