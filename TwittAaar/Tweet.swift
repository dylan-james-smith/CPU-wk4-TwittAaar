//
//  Tweet.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/7/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
//    var timeSince: String?
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
//        let now = NSDate()
//        let then = createdAt
//        timeSince = String(String: now.timeIntervalSinceDate(then!))

    
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
//            print("tweets: \(tweets)")
        }
        
        return tweets
    }
}
