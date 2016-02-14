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
    
    var toggleLike = 0
    var toggleRetweet = 0
    
    @available(iOS, deprecated=8.0) //suppress warning on deprecated GET from BDBOAuth1Manager's GET method (thanks Sarn!)
    override func viewDidLoad() {
        super.viewDidLoad()
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
//            print(tweets)
        }
        
        
        // Do any additional setup after loading the view.
    }

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
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            
            cell.profileImageView.setImageWithURL(NSURL(string: tweets![indexPath.row].user!.profileImageUrl!)!)
            cell.nameLabel.text = tweets![indexPath.row].user?.name
            cell.screenNameLabel.text = "@"+(tweets![indexPath.row].user?.screenname)!
            cell.tweetLabel.text = tweets![indexPath.row].text
            cell.timeLabel.text = tweets![indexPath.row].timeSince
            
//            cell.retweetCountLabel.text = tweets![indexPath.row].favorite_count
//            cell.favoriteCountLabel.text = tweets![indexPath.row].
            
           
            return cell
        }
    
    func onRefresh(){
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    

    @IBAction func onLike(sender: AnyObject) {
//                 toggle = indexPath NSUserDefults and or dictionary sets toggle state
        let type = "like"
        
        if toggleLike == 1 {
            sender.setImage(UIImage(named: type+"-action"), forState: UIControlState.Normal)
//      increment Pressed Button to API and set text color of count
            print(">>> toggle off -1")
            toggleLike = 0
        }else{
            sender.setImage(UIImage(named: type+"-action-on"), forState: UIControlState.Normal)
//      subtract Pressed Button to API and set text color of count
            print(">>> toggle on +1")
            toggleLike = 1
        }
        
        
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        //                 toggle = indexPath NSUserDefults and or dictionary sets toggle state
        let type = "retweet"
        
        if toggleRetweet == 1 {
            sender.setImage(UIImage(named: type+"-action"), forState: UIControlState.Normal)
            //      increment Pressed Button to API and set text color of count
            print(">>> toggle off -1")
            toggleRetweet = 0
        }else{
            sender.setImage(UIImage(named: type+"-action-on"), forState: UIControlState.Normal)
            //      subtract Pressed Button to API and set text color of count
            print(">>> toggle on +1")
            toggleRetweet = 1
        }
        
        
    }

    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
