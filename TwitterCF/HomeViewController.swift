//
//  ViewController.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/26/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var tweets = [Tweet]()

    class func identifier() -> String {
        return "HomeViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.getTweets()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getAccount()
    }
    
    
    func getAccount() {
        AccessTwitterAccount.loginTwitter { (error, account) -> () in
            if let error = error {
                print(error); return
            }
            if let account = account {
                TwitterTimeline.sharedService.accounts = account
                self.authAccount()
            }
        }
    }
    
    func getTweets() {
        TwitterTimeline.getTweetTimeline { (error, tweets) -> () in
            if let error = error {
                print(error); return
            }
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                    self.tableView.reloadData()
                })
            }
        }
        
    }
    
    func authAccount() {
        TwitterTimeline.getAuthUser { (error, User) -> () in
            if let error = error {
                print(error); return
            }
            if let user = User {
                TwitterTimeline.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    // MARK: UITableView
    

    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        
        let tweet = self.tweets[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = "Tweet posted by: \(tweet.user!.name)"
        
        return cell
    }
}

