//
//  TwittAaarViewController.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/6/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking



class TwittAaarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cputwittaaar://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("request token: success")
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
            print("request token: failed")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
