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
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
//        Hacky time string d, h, or m
        let now = NSDate()
        let then = createdAt
        timePassed = Int(now.timeIntervalSinceDate(then!))
//        print(timePassed)
        
        if timePassed >= 86400{
            timeSince = String(timePassed! / 86400)+"d"
//            print(timeSince)
        
        }
        if (3600..<86400).contains(timePassed!){
            timeSince = String(timePassed!/3600)+"h"
//            print(timeSince)
        }
        if (60..<3600).contains(timePassed!){
            timeSince = String(timePassed!/60)+"m"
//            print(timeSince)
        }
        if timePassed < 60 {
            timeSince = String(timePassed!)+"s"
//            print(timeSince)
        }
        
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
