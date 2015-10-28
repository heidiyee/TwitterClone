//
//  twitterTimeline.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/28/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterTimeline {
    
    static let sharedService = TwitterTimeline()
    
    var accounts: ACAccount?
    var user: User?

    
    class func getTweetTimeline(completion: (String?, [Tweet]?) -> () ) {
        
        let requestTimeline = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
        if let account = sharedService.accounts {
            requestTimeline.account = account
            
            requestTimeline.performRequestWithHandler { (data, response, error) -> Void in
                
                if let error = error {
                    print(error.description)
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json could not be completed.", nil); return
                }
                print(response.description)
                
                switch response.statusCode {
                case 200...299:
                    let tweets = TweetJSONParser.tweetFromJSONData(data)
                    completion(nil, tweets)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [unknown error].", nil)
                }

            }
        }
    }
}
