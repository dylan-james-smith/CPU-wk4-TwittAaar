//
//  User.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/7/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    
    var dictionary: NSDictionary
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var backgroundImageURL: String?
    var tagline: String?
    var location: String?
    var website: String?
    var websiteURL: String?
    var followingCount: Float?
    var followingCountStr: String?
    var followerCount: Float?
    var followerCountStr: String?
    var tweetsCount: NSNumber?
    var id: Int?
    
    var formatFloat: String?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
//        profileImageUrl = dictionary["profile_image_url_https"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        profileImageUrl = NSURL(string: (profileUrlString?.stringByReplacingOccurrencesOfString("normal", withString: "bigger"))!)
        backgroundImageURL = dictionary["profile_banner_url"] as? String
        tagline = dictionary["description"] as? String
        location = dictionary["location"] as? String
        
        if let entitiesDict = dictionary["entities"] as? NSDictionary {
            if let urlDict = entitiesDict["url"] as? NSDictionary {
                if let urlsArray = urlDict["urls"] as? NSArray {
                    if let urlsDict = urlsArray[0] as? NSDictionary {
                        website = urlsDict["display_url"] as? String
                        websiteURL = urlsDict["expanded_url"] as? String
//                        print(website, websiteURL)
//                        print("urlsDict",(urlsDict),"WEBSITE:",(website!))
                    }
//                    print("urlsArray",(urlsArray))
                }
//                print("urlDict", (urlDict))
            }
//            print("entitiesDict",(entitiesDict))
        }
        
        
        
        followingCount = dictionary["friends_count"] as? Float
        followerCount = dictionary["followers_count"] as? Float
        tweetsCount = dictionary["statuses_count"] as? Int
        id = dictionary["id"] as? Int

//        print("V",  (dictionary))
        print("L", (dictionary))

        if followingCount! > 1050000{
            if followingCount!%1000000 > 500000 {
                formatFloat = "%.01f"
            }else{
                formatFloat = "%.00f"
            }
//            print(name, followingCount!%1000000,formatFloat)
            followerCountStr = (String(format: formatFloat!,followingCount!/1000000)+"M")
        }else if followingCount! > 950000{
            followingCountStr = "1M"
        }else if followingCount! > 1070{
            followingCountStr = (String(format: "%.01f",followingCount!/1000)+"K")
        }else if followingCount! > 950{
            followingCountStr = "1K"
        }else{
            followingCountStr = String(format:"%.00f",followingCount!)
        }
//        print(followingCountStr)
        
        if followerCount! > 1050000{
            if followerCount!%1000000 > 500000 {
                formatFloat = "%.01f"
            }else{
                formatFloat = "%.00f"
            }
//            print(name,followerCount!%1000000,formatFloat)
            followerCountStr = (String(format: formatFloat!,followerCount!/1000000)+"M")
        }else if followerCount! > 950000{
            followerCountStr = "1M"
        }else if followerCount! > 1070{
            followerCountStr = (String(format: "%.01f",followerCount!/1000)+"K")
        }else if followerCount! > 950{
            followerCountStr = "1K"
        }else{
            followerCountStr = String(format:"%.00f", followerCount!)
        }
//        print(name!,followerCountStr!)

    }

    func logout() {
        print("User log out")
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch _ {
        
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch _ {
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}