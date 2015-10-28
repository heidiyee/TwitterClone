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
            
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
            
                var tweets = [Tweet]()
            
                for tweetObject in rootObject {
                    
                    if let text = tweetObject["text"] as? String, id = tweetObject["id_str"] as? String, userDictionary = tweetObject["user"] as? [String: AnyObject] {
                        
                        let tweet = Tweet(text: text, id: id)

                        if let name = userDictionary["name"] as? String, profileImageUrl = userDictionary["profile_image_url"] as? String {
                            
                            tweet.user = User(name: name, profileImageUrl: profileImageUrl)
                            
                        }

                        tweets.append(tweet)
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
    
}
