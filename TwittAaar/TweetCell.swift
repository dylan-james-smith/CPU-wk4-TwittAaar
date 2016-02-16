//
//  TweetCell.swift
//  TwittAaar
//
//  Created by Dylan Smith on 2/9/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweetID: String = ""
    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            nameLabel.text = tweet.user!.name
            screenNameLabel.text = "@"+(tweet.user?.screenname)!
            timeLabel.text = tweet.timeSince
            tweetLabel.text = tweet.text
            
            tweetID = tweet.id
            retweetCountLabel.text = String(tweet.retweetCount!)
            favoriteCountLabel.text = String(tweet.favoritesCount!)
        
            //            hide count text if 0
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
            
            //            check if retweet button and text is "on"
            if NSUserDefaults.standardUserDefaults().boolForKey("toggleRetweet"+tweet.id){
                retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
                retweetCountLabel.textColor = UIColor(red: 0x19/255, green: 0xcf/255, blue: 0x86/255, alpha: 1.0)
//                count text mockup
                retweetCountLabel.text = String(Int(tweet.retweetCount!) + 1)
            }
            //            check if favorite button and text is "on"
            if NSUserDefaults.standardUserDefaults().boolForKey("toggleFavorite"+tweet.id){
                favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
                favoriteCountLabel.textColor = UIColor(red: 0xe8/255, green: 0x1c/255, blue: 0x4f/255, alpha: 1.0)
//                count text mockup
                retweetCountLabel.text = String(Int(tweet.favoritesCount!) + 1)
            }
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
//        NSLog(">>>awakeFromNib")
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
//        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        NSLog(">>>layoutSubviews")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        NSLog(">>>setSelected")

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweet(sender: UIButton) {
//        NSLog(">>>onRetweet")
        if NSUserDefaults.standardUserDefaults().boolForKey("toggleRetweet"+tweet.id) {
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
            retweetCountLabel.textColor =  UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
            retweetCountLabel.text = String(tweet.retweetCount!)
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            print(">>> toggle retweet off (-1)")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey:"toggleRetweet"+tweet.id)
        }else{
            retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
            retweetCountLabel.textColor =  UIColor(red: 0x19/255, green: 0xcf/255, blue: 0x86/255, alpha: 1.0)
            retweetCountLabel.text = String(Int(tweet.retweetCount!) + 1)
            retweetCountLabel.hidden = false
            print(">>> toggle retweet on (+1)")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"toggleRetweet"+tweet.id)
        }
    }
    
    @IBAction func onFavorite(sender: UIButton) {
//        NSLog(">>>onFavorite")
        if NSUserDefaults.standardUserDefaults().boolForKey("toggleFavorite"+tweet.id) {
            favoriteButton.setImage(UIImage(named: "like-action"), forState: UIControlState.Normal)
            favoriteCountLabel.textColor =  UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
            favoriteCountLabel.text = String(tweet.favoritesCount!)
            favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
            print(">>> toggle faviorite off -1")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey:"toggleFavorite"+tweet.id)
        }else{
            favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
            favoriteCountLabel.textColor =  UIColor(red: 0xe8/255, green: 0x1c/255, blue: 0x4f/255, alpha: 1.0)
            favoriteCountLabel.text = String(Int(tweet.favoritesCount!) + 1)
            favoriteCountLabel.hidden = false
            print(">>> toggle faviorite on +1")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"toggleFavorite"+tweet.id)
        }
    }
    

}
