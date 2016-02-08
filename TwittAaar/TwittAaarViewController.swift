//
//  TwittAaarViewController.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/6/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//


import UIKit

class TwittAaarViewController: UIViewController {
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // handle error
                print("Login Error")
            }
        }
        
    } 
//import UIKit
//import BDBOAuth1Manager
//
//
//
//class TwittAaarViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//         
//       // Do any additional setup after loading the view.
//      TwitterClient.sharedInstance.homeTimelineWithParams(nil , completion: { (tweets, error) -> () in
//              self.tweets = tweets
//              //can reload here too
//        })
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    @IBAction func onLogin(sender: AnyObject) {
//        
//        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
//        
//        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "heydylan://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
//            print("request token: success")
//            let authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
//            UIApplication.sharedApplication().openURL(authURL!)
//            }) { (error: NSError!) -> Void in
//            print("request token: failed")
//        }
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
