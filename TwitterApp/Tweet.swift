//
//  Tweet.swift
//  TwitterApp
//
//  Created by macbookair11 on 2/20/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user : User?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0;
    var favoritesCount: Int = 0;
    var tweetID: String?
    var favorite: Bool?
    var retweet: Bool?
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        favorite = dictionary["favorited"] as? Bool
        retweet = dictionary["retweeted"] as? Bool
        tweetID = dictionary["id_str"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            timestamp = formatter.dateFromString(timestampString)
           
            
        }
        
        
    }
    
    
    
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    
    }
}
