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
    var timePassed: Int?
    var timeSince: String!
    var retweetCount: NSNumber?
    var favoritesCount: NSNumber?
    var id: String
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        favoritesCount = dictionary["favorite_count"] as? Int
        id = String(dictionary["id"]!)
        
        

//        Time keeps on tickin' tickin' tickin'
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
//        Hacky time string d, h, or m
        let now = NSDate()
        let then = createdAt
        timePassed = Int(now.timeIntervalSinceDate(then!))
//        print(timePassed)
//        days
        if timePassed >= 86400{
            timeSince = String(timePassed! / 86400)+"d"
//            print(timeSince)
//            hours
        }
        if (3600..<86400).contains(timePassed!){
            timeSince = String(timePassed!/3600)+"h"
//            print(timeSince)
//            minutes
        }
        if (60..<3600).contains(timePassed!){
            timeSince = String(timePassed!/60)+"m"
//            print(timeSince)
//            seconds
        }
        if timePassed < 60 {
            timeSince = String(timePassed!)+"s"
//            print(timeSince)
        }
//        End Times
        
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
//            print("tweets: \(tweets)")
        }
        
        return tweets
    }
    
//    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
//        var tweet = Tweet(dictionary: dict)
//        return tweet
//    }
}
