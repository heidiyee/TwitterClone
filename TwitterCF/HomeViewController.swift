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
        
        print("Hi")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //self.getAccount()
    }
    
    func getTweets() {
        if let tweetJSONFileUrl = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") {
            if let tweetJSONData = NSData(contentsOfURL: tweetJSONFileUrl) {
                if let tweets = TweetJSONParser.tweetFromJSONData(tweetJSONData) {
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getAccount() {
        AccessTwitterAccount.loginTwitter { (error, account) -> () in
            if let error = error {
                print(error); return
            }
            if let account = account {
                TwitterTimeline.sharedService.accounts = account
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
        cell.detailTextLabel?.text = "Tweet id: \(tweet.id)"
        
        return cell
    }
}

