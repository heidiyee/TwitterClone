//
//  TweetJSONParser.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/26/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import Foundation

class TweetJSONParser {
    
    class func tweetFromJSONData (json: NSData) -> [Tweet]? {
        
        do {
            
//            var dataAsString = NSString(data: json, encoding: NSUTF8StringEncoding)
//            print(dataAsString)
            
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                
                //print(rootObject)
            
                var tweets = [Tweet]()
            
                for tweetObject in rootObject {
                
                    
                    
                    if let text = tweetObject["text"] as? String, id = tweetObject["id_str"] as? String, userDictionary = tweetObject["user"] as? [String: AnyObject] {
                        
                        let retweetCheck = self.isRetweet(tweetObject)
                        if retweetCheck.0 == true {
                            if let newObject = retweetCheck.2 {
                                if let currentUser = userFromJSONData(userDictionary), originalUser = userFromJSONData(newObject) {
                                    let tweet = Tweet(text: text, id: id, user: currentUser, retweetText: retweetCheck.1, retweetUser: originalUser, retweetBool: true)
                                    tweets.append(tweet)
                                }
                            }
                        } else {
                        
                            let tweet = Tweet(text: text, id: id, retweetBool: false)
                            if let name = userDictionary["name"] as? String, profileImageUrl = userDictionary["profile_image_url"] as? String {
                            
                                tweet.user = User(name: name, profileImageUrl: profileImageUrl)
                        
                            }
                            tweets.append(tweet)
                        }
                    }
                }
                return tweets
                
            }
                
                
        } catch _ {
        
            return nil
        }
        
        return nil
    }
    
    class func userFromJSONData (userDictionary: [String: AnyObject]) -> User? {
        if let name = userDictionary["name"] as? String, profileImageUrl = userDictionary["profile_image_url"] as? String {
            return User(name: name, profileImageUrl: profileImageUrl)
        }
        return nil
    }
    
    class func isRetweet (tweetObject: [String: AnyObject]) -> (Bool, String?, [String: AnyObject]?) {
        
        if let retweetedStatus = tweetObject["retweeted_status"] as? [String:AnyObject] {
            print("RT")
            if let originalText = retweetedStatus["text"] as? String, originalUserDictionary = retweetedStatus["user"] as? [String: AnyObject] {
                return (true, originalText, originalUserDictionary)
            }
        }
        return (false, nil, nil)
    }
    
}
