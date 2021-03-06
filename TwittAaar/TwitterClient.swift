//
//  TwitterClient.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/6/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "9F0cMCCLVzDBioFjydqBAc3rM"
let twitterConsumerSecret = "BFnIMPqbmdWJmTk8mVQbgYGC9Vp9de02qB8x7pKsS5O1QZNN4i"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
//            print(tweets)
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print("home timeline: ERROR")
                completion(tweets: nil, error: error)
        })
        
    }
    
    func userTimeline(user: User, maxId: Int? = nil, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        var params = ["count": 10]
        params["user_id"] = user.id
        if(maxId != nil) {
            params["max_id"] = maxId
        }
        
        GET("1.1/statuses/user_timeline.json", parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    
    @available(iOS, deprecated=8.0) //suppress warning (thanks Sarn!)
    func favoriteStatus(tweetID: Int, completion: (error: NSError?) -> ()) {
        POST("/1.1/favorites/create.json", parameters: ["id": tweetID], success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, err: NSError!) -> Void in
                completion(error: err)
        })
    }
    
    @available(iOS, deprecated=8.0) //suppress warning (thanks Sarn!)
    func unfavoriteStatus(tweetID: Int, completion: (error: NSError?) -> ()) {
        POST("/1.1/favorites/destroy.json", parameters: ["id": tweetID], success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, err: NSError!) -> Void in
                completion(error: err)
        })
    }
    
    @available(iOS, deprecated=8.0) //suppress warning (thanks Sarn!)
    func retweetStatus(tweetID: Int, completion: (retweetedTweetID: Int?, error: NSError?) -> ()) {
        POST("/1.1/statuses/retweet/\(tweetID).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //let tweetArray = Tweet.tweetsfromJSON(JSON(response))
            //completion(retweetedTweetID: tweetArray.first?.tweetID, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, err: NSError!) -> Void in
                completion(retweetedTweetID: nil, error: err)
        })
    }
    
    @available(iOS, deprecated=8.0) //suppress warning (thanks Sarn!)
    func unretweetStatus(retweetedTweetID: Int, completion: (error: NSError?) -> ()) {
        POST("/1.1/statuses/destroy/\(retweetedTweetID).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, err: NSError!) -> Void in
                completion(error: err)
        })
    }
    
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        
        loginCompletion = completion
        
        requestSerializer.removeAccessToken()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "heydylan://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("request token: success")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("request token: failed")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
    func openURL(url: NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query)!, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("access token: gained")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                    print("current user: ERROR")
                    self.loginCompletion?(user: nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                print("access token: failure")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
}

