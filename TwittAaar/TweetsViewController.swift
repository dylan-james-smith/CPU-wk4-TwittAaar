 //
//  TweetsViewController.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/8/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    
    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon = UIImage(named: "Icon.png")
        let iconImageView = UIImageView(image: icon)
        self.navigationItem.titleView = iconImageView
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
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
        let cell =  tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
    func onRefresh(){
//            NSLog(">>>onRefresh")
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
//            self.tweets = tweets
//            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        super.prepareForSegue(UIStoryboardSegue, sender: AnyObject?)
        if segue.identifier == "profileImage2View" {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let user = tweet.user
            let destViewController = segue.destinationViewController as! ProfileViewController
            destViewController.tweet = tweet
            destViewController.user = user
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.image = UIImage(named: "Icon_white")
        navigationItem.backBarButtonItem = backItem
    }

}
