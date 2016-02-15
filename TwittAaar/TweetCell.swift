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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        NSLog(">>>awakeFromNib")
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        
//        retweetCountLabel.textColor = UIColor(
//            red: 0x19/255,
//            green: 0xcf/255,
//            blue: 0x86/255,
//            alpha: 1.0)
//        
//        favoriteCountLabel.textColor = UIColor(
//            red: 0xe8/255,
//            green: 0x1c/255,
//            blue: 0x4f/255,
//            alpha: 1.0)
        
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

}
