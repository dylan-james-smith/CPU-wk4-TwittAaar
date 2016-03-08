//
//  ProfileCell.swift
//  TwittAaar
//
//  Created by Dylan Smith on 3/2/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetBigButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteBigButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweetID: String = ""
    var tweet: Tweet!
    var user: User! {
        didSet {
            
            tweetID = tweet.tweetID
            
            profileImageView.setImageWithURL(user.profileImageUrl!)
            nameLabel.text = user.name
            screenNameLabel.text = user.screenname
            tweetLabel.text = tweet.text
            timeLabel.text = tweet.timeSince
            retweetCountLabel.text = String(tweet.retweetCount!)
            favoriteCountLabel.text = String(tweet.favoritesCount!)
            
            //            Check for Retweet or Like
            if NSUserDefaults.standardUserDefaults().boolForKey("toggleRetweet"+tweet.tweetID){
                retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
                retweetCountLabel.textColor = UIColor(red: 0x19/255, green: 0xcf/255, blue: 0x86/255, alpha: 1.0)
                //                count text mockup
                retweetCountLabel.text = String(Int(tweet.retweetCount!) + 1)
            }else{
                retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
                retweetCountLabel.textColor = UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
            }
            
            //            check if favorite button and text is "on"
            if NSUserDefaults.standardUserDefaults().boolForKey("toggleFavorite"+tweet.tweetID){
                favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
                favoriteCountLabel.textColor = UIColor(red: 0xe8/255, green: 0x1c/255, blue: 0x4f/255, alpha: 1.0)
                //                count text mockup
                favoriteCountLabel.text = String(Int(tweet.favoritesCount!) + 1)
            }else{
                favoriteButton.setImage(UIImage(named: "like-action"), forState: UIControlState.Normal)
                favoriteCountLabel.textColor = UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
            }
            
            //          hide count text if 0
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
            
//            Some insparation from TJ
//            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("profileCogMenu"));
//            imageCogIcon.userInteractionEnabled = true;
//            imageCogIcon.addGestureRecognizer(tapGestureRecognizer);
//            
//            let gradientLayer = CAGradientLayer();
//            gradientLayer.frame = shadowEffectView.bounds;
//            let topColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor as CGColorRef;
//            let bottomColor = UIColor(white: 0, alpha: 0.0).CGColor as CGColorRef;
//            gradientLayer.colors = [topColor, bottomColor];
//            gradientLayer.locations = [0.0, 1.0];
//            self.shadowEffectView.layer.addSublayer(gradientLayer);
            
        }
    }
    

//    var tweet: Tweet! {
//        
//        didSet {
//            profileImageView.setImageWithURL(tweet.user!.profileImageUrl!)
//            nameLabel.text = tweet.user!.name
//            screenNameLabel.text = "@"+(tweet.user?.screenname)!
//            timeLabel.text = tweet.timeSince
//            tweetLabel.text = tweet.text
//            
//            tweetID = tweet.tweetID
//            retweetCountLabel.text = String(tweet.retweetCount!)
//            favoriteCountLabel.text = String(tweet.favoritesCount!)
//            
//            //            Check for Retweet or Like
//            if NSUserDefaults.standardUserDefaults().boolForKey("toggleRetweet"+tweet.tweetID){
//                retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
//                retweetCountLabel.textColor = UIColor(red: 0x19/255, green: 0xcf/255, blue: 0x86/255, alpha: 1.0)
//                //                count text mockup
//                retweetCountLabel.text = String(Int(tweet.retweetCount!) + 1)
//            }else{
//                retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
//                retweetCountLabel.textColor = UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
//            }
//            
//            //            check if favorite button and text is "on"
//            if NSUserDefaults.standardUserDefaults().boolForKey("toggleFavorite"+tweet.tweetID){
//                favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
//                favoriteCountLabel.textColor = UIColor(red: 0xe8/255, green: 0x1c/255, blue: 0x4f/255, alpha: 1.0)
//                //                count text mockup
//                favoriteCountLabel.text = String(Int(tweet.favoritesCount!) + 1)
//            }else{
//                favoriteButton.setImage(UIImage(named: "like-action"), forState: UIControlState.Normal)
//                favoriteCountLabel.textColor = UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
//            }
//            
//            //          hide count text if 0
//            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
//            favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
//            
//            
//        }
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        NSLog(">>>awakeFromNib")
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        
        
        //        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    //    func onProfileImageViewTap(){
    //        print("I've been tapped", tweet.user?.name)
    //    }
    
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
        if NSUserDefaults.standardUserDefaults().boolForKey("toggleRetweet"+tweet.tweetID) {
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
            retweetCountLabel.textColor =  UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
            retweetCountLabel.text = String(tweet.retweetCount!)
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            //            print(">>> toggle retwee off (-1)")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey:"toggleRetweet"+tweet.tweetID)
        }else{
            retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
            retweetCountLabel.textColor =  UIColor(red: 0x19/255, green: 0xcf/255, blue: 0x86/255, alpha: 1.0)
            retweetCountLabel.text = String(Int(tweet.retweetCount!) + 1)
            retweetCountLabel.hidden = false
            //            print(">>> toggle retweet on (+1)")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"toggleRetweet"+tweet.tweetID)
        }
    }
    
    @IBAction func onFavorite(sender: UIButton) {
        //        NSLog(">>>onFavorite")
        if NSUserDefaults.standardUserDefaults().boolForKey("toggleFavorite"+tweet.tweetID) {
            favoriteButton.setImage(UIImage(named: "like-action"), forState: UIControlState.Normal)
            favoriteCountLabel.textColor =  UIColor(red: 0xaa/255, green: 0xb8/255, blue: 0xc2/255, alpha: 1.0)
            favoriteCountLabel.text = String(tweet.favoritesCount!)
            favoriteCountLabel.text! == "0" ? (favoriteCountLabel.hidden = true) : (favoriteCountLabel.hidden = false)
            //            print(">>> toggle faviorite off -1")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey:"toggleFavorite"+tweet.tweetID)
        }else{
            favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
            favoriteCountLabel.textColor =  UIColor(red: 0xe8/255, green: 0x1c/255, blue: 0x4f/255, alpha: 1.0)
            favoriteCountLabel.text = String(Int(tweet.favoritesCount!) + 1)
            favoriteCountLabel.hidden = false
            //            print(">>> toggle faviorite on +1")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"toggleFavorite"+tweet.tweetID)
        }
    }
    
    
    
}
