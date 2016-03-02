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
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    var tweetID = ""
    var retweeted: Bool!
    var favorited: Bool!
    
    var tweet : Tweet! {
        
        didSet {
            let imageUrl = tweet.user?.profileUrl
            porfileView.setImageWithURL(NSURL(string: imageUrl!)!)
            nameLabel.text = tweet.user?.name
            tagLabel.text = "@\(tweet.user?.screenname)"
            tweetLabel.text = tweet.text
            timeLabel.text = calculateTime(tweet.timestamp!.timeIntervalSinceNow)
            
            if(tweet.retweetCount >= 1000000) {
                retweetCountLabel.text = "\(tweet.retweetCount/1000000)M"
            }
            else if(tweet.retweetCount >= 1000) {
                retweetCountLabel.text = "\(tweet.retweetCount/1000)K"
            } else {
                retweetCountLabel.text = "\(tweet.retweetCount)"
            }
            
            if(tweet.favoritesCount >= 1000000) {
                favoriteCountLabel.text = "\(tweet.favoritesCount/1000000)M"
            }
            else if(tweet.favoritesCount >= 1000) {
                favoriteCountLabel.text = "\(tweet.favoritesCount/1000)K"
            } else {
                favoriteCountLabel.text = "\(tweet.favoritesCount)"
            }
            
            //Get the tweet id
            tweetID = tweet.tweetID!
            retweeted = tweet.retweet
            favorited = tweet.favorite
            if (retweeted == false) {
                
                if let image = UIImage(named: "retweet-action") {
                    retweetButton.setImage(image, forState: .Normal)
                }
            }
            else {
                if let image = UIImage(named: "retweet-action-on") {
                    retweetButton.setImage(image, forState: .Normal)
                }
            }
            if (favorited == false) {
                if let image = UIImage(named: "like-action") {
                    favoriteButton.setImage(image, forState: .Normal)
                }
            }
            else {
                if let image = UIImage(named: "like-action-on") {
                    favoriteButton.setImage(image, forState: .Normal)
                }
            }

            
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
    
    func calculateTime(timestamp: NSTimeInterval) -> String {
        var rawTime = Int(timestamp)
        rawTime = rawTime * (-1)
        var time: Int = 0
        var timechar = ""
        if (rawTime <= 60) {
            time = rawTime
            timechar = "s"
        } else if((rawTime/60) <= 60) {
            time = rawTime/60
            timechar = "m"
            
        } else if((rawTime/60/60) <= 24) {
            
            time = rawTime/60/60
            timechar = "h"
            
        } else if((rawTime/60/60/24) <= 365) {
            
            time = rawTime/60/60/24
            timechar = "d"
            
        } else if (rawTime/(3153600) <= 1) {
            
            time = rawTime/60/60/24/365
            timechar = "y"
        }
        
        return "\(time)\(timechar)"
        
    }
    
    
    
    @IBAction func retweetButtonClicked(sender: AnyObject)
        {
        
            
            if(retweeted == false){
                TwitterClient.sharedInstance.retweet(tweetID)
                retweeted = true
                if let image = UIImage(named: "retweet-action-on") {
                    retweetButton.setImage(image, forState: .Normal)
                }
                tweet.retweetCount = tweet.retweetCount + 1
                if(tweet.retweetCount >= 1000000) {
                    retweetCountLabel.text = "\(tweet.retweetCount/1000000)M"
                }
                else if(tweet.retweetCount >= 1000) {
                    retweetCountLabel.text = "\(tweet.retweetCount/1000)K"
                } else {
                    retweetCountLabel.text = "\(tweet.retweetCount)"
                }
                
                
            }
            else {
                TwitterClient.sharedInstance.unretweet(tweetID)
                retweeted = false
                if let image = UIImage(named: "retweet-action") {
                    retweetButton.setImage(image, forState: .Normal)
                }
                tweet.retweetCount = tweet.retweetCount - 1
                if(tweet.retweetCount >= 1000000) {
                    retweetCountLabel.text = "\(tweet.retweetCount/1000000)M"
                }
                else if(tweet.retweetCount >= 1000) {
                    retweetCountLabel.text = "\(tweet.retweetCount/1000)K"
                } else {
                    retweetCountLabel.text = "\(tweet.retweetCount)"
                }
                
            }

    }
    

    @IBAction func favoriteButtonClicked(sender: AnyObject)
    {
        
        
        if(favorited == false) {
            TwitterClient.sharedInstance.favorites(tweetID)
            favorited = true
            if let image = UIImage(named: "like-action-on") {
                favoriteButton.setImage(image, forState: .Normal)
            }
            tweet.favoritesCount = tweet.favoritesCount + 1
            if(tweet.favoritesCount >= 1000000) {
                favoriteCountLabel.text = "\(tweet.favoritesCount/1000000)M"
            }
            else if(tweet.favoritesCount >= 1000) {
                favoriteCountLabel.text = "\(tweet.favoritesCount/1000)K"
            } else {
                favoriteCountLabel.text = "\(tweet.favoritesCount)"
            }
            
        }
        else {
            TwitterClient.sharedInstance.unfavorite(tweetID)
            favorited = false
            if let image = UIImage(named: "like-action") {
                favoriteButton.setImage(image, forState: .Normal)
            }
            tweet.favoritesCount = tweet.favoritesCount - 1
            if(tweet.favoritesCount >= 1000000) {
                favoriteCountLabel.text = "\(tweet.favoritesCount/1000000)M"
            }
            else if(tweet.favoritesCount >= 1000) {
                favoriteCountLabel.text = "\(tweet.favoritesCount/1000)K"
            } else {
                favoriteCountLabel.text = "\(tweet.favoritesCount)"
            }
            
            
        }
        
    }
    
    
    

    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    

}
