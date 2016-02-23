//
//  ProfileViewController.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/20/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var profileData: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = UIColor.whiteColor()
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
//        profileImageView.setImageWithURL(NSURL(fileURLWithPath: (profileData.user?.profileImageUrl)!))
        
//TwitterClient.sharedInstance.
        
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
//            self.tweets = tweets
//            self.tableView.reloadData()
//            self.refreshControl.endRefreshing()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.translucent = true
//        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        NSLog(">>>tableView numberOfRowsInSection")
//        if tweets != nil {
//            return tweets!.count
//        } else {
            return 0
//        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //            NSLog(">>>tableView cellForRowAtIndexPath")
        let cell =  tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.selectionStyle = .None
//        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    
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
