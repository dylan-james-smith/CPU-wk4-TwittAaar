//
//  ProfileViewController.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/22/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var tweets: [Tweet]?
    var tweet: Tweet!
    var user: User!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileScreennameLabel: UILabel!
    @IBOutlet weak var profileTagLabel: UILabel!
    @IBOutlet weak var profileLocationLabel: UILabel!
    @IBOutlet weak var profileWebsiteLabel: UILabel!
    @IBOutlet weak var profileFollowingCountLabel: UILabel!
    @IBOutlet weak var profileFollowersCountLabel: UILabel!
    
    
    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //            let icon = UIImage(named: "Icon.png")
        //            let iconImageView = UIImageView(image: icon)
        //            self.navigationItem.titleView = iconImageView
        
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = UIColor.whiteColor()
        profileImageView.setImageWithURL(user.profileImageUrl!)
        
        if user.backgroundImageURL != nil{
            profileBackgroundImageView.setImageWithURL(NSURL(string: (user.backgroundImageURL)!)!)
        }
        profileNameLabel.text = user.name
        profileScreennameLabel.text = "@"+(user.screenname)!
        profileTagLabel.text = user.tagline
        profileLocationLabel.text = user.location
        profileWebsiteLabel.text = user.website
        profileFollowingCountLabel.text = user.followingCountStr
        profileFollowersCountLabel.text = user.followerCountStr
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }


        
        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillAppear(animated: Bool) {
    //        print("viewWillAppear")
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        NSLog(">>>tableView numberOfRowsInSection")
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //            NSLog(">>>tableView cellForRowAtIndexPath")
        let cell =  tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
        
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
//    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
//    func onRefresh(){
//        //            NSLog(">>>onRefresh")
//        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
//            self.tweets = tweets
//            self.tableView.reloadData()
//        }
//    }
//    
//    
//    @IBAction func onLogout(sender: AnyObject) {
//        User.currentUser?.logout()
//    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = nil
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
