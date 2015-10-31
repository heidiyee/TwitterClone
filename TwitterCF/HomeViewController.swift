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
        self.getAccount()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //... 
        self.tableView.estimatedRowHeight = 2
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let customTweetCellXib = UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomTweetViewCell.identifier())
        
    }
    
    //Logging in to Twitter, verifying account, getting timeline tweets of that account

    
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

    
    // MARK: UITableView
    

    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomTweetViewCell.identifier(), forIndexPath: indexPath) as! CustomTweetViewCell
        cell.tweet = self.tweets[indexPath.row]
    
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let detailedViewController = self.storyboard?.instantiateViewControllerWithIdentifier(DetailViewController.identifier()) as! DetailViewController
        detailedViewController.tweet = self.tweets[indexPath.row]
        self.navigationController?.pushViewController(detailedViewController, animated: true)
    
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "DetailViewController" {
//            
//            if let listedViewController = segue.destinationViewController as? DetailViewController {
//
//                if let myIndexPath = self.tableView.indexPathForSelectedRow {
//                    
//                    let tweet = self.tweets[myIndexPath.row]
//                    listedViewController.tweet = tweet
//                }
//            }
//        }
//    }
    
    
}

