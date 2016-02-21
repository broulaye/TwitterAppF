//
//  TweetCell.swift
//  TwitterApp
//
//  Created by macbookair11 on 2/20/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var porfileView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var tweet : Tweet! {
        
        didSet {
            let imageUrl = tweet.user?.profileUrl
            porfileView.setImageWithURL(NSURL(string: imageUrl!)!)
            nameLabel.text = tweet.user?.name
            tagLabel.text = tweet.user?.tagline
            tweetLabel.text = tweet.text
            timeLabel.text = tweet.timestamp?.description
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        porfileView.layer.cornerRadius = 3
        porfileView.clipsToBounds = true
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
