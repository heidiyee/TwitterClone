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
    
    class func getUserStatusWithUserName (userName: String, completion: (String?, [Tweet]?) -> ()) {
        
        var parameters = [String:AnyObject]()
        parameters["screen_name"] = userName
        
        let requestStatus = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?"), parameters: parameters)
    
        
        if let account = sharedService.accounts {
            requestStatus.account = account
            
            requestStatus.performRequestWithHandler { (data, response, error) -> Void in
                
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
    
    class func getAuthUser(completion: (String?, User?)-> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        if let accounts = self.sharedService.accounts {
            request.account = accounts
            
            request.performRequestWithHandler { (data, response, error) -> Void in
                
                if let error = error {
                    print(error)
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json could not be completed.", nil); return
                }
                
                switch response.statusCode {
                case 200...299:
                    do {
                        if let userData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] {
                            if let user = TweetJSONParser.userFromJSONData(userData){
                                completion(nil, user); return
                            }
                            completion("ERROR: unable create user object from de-serialized JSON object", nil)
                        }
                    } catch {
                        completion("ERROR: NSJSONSerialization.JSONObjectWithData was unable to de-serialize JSON object.", nil)
                    }

                default:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [unknown error].", nil)
                }
            }
        }
    }
    
}
