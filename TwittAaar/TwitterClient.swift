//
//  TwitterClient.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/6/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "SJGvJKN5jYIDtRpuSuJVekmix"
let twitterConsumerSeceret = "rcyGOkIbrhsor5gvavL4cTO7OkyomQeGh6mYn889D7mTsUEjmr"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient (baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSeceret)
            }
        return Static.instance
        }
    }



