//
//  TwitterDetailViewController.swift
//  TwitterApp
//
//  Created by macbookair11 on 2/28/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit

class TwitterDetailViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    @IBOutlet weak var tweetLikeLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var tweetID = ""
    var retweeted: Bool!
    var favorited: Bool!
    var tweet: Tweet!
   // var user: User

    

  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = tweet.user?.profileUrl
        profilePic.setImageWithURL(NSURL(string: imageUrl!)!)
        nameLabel.text = tweet.user?.name
        tagLabel.text = "@\(tweet.user?.screenname)"
        
        tweetLabel.text = tweet.text
        /*
        timeLabel.text = calculateTime(tweet.timestamp!.timeIntervalSinceNow)
        */
        if(tweet.retweetCount >= 1000000) {
            tweetCountLabel.text = "\(tweet.retweetCount/1000000)M"
        }
        else if(tweet.retweetCount >= 1000) {
            tweetCountLabel.text = "\(tweet.retweetCount/1000)K"
        } else {
            tweetCountLabel.text = "\(tweet.retweetCount)"
        }
        
        if(tweet.favoritesCount >= 1000000) {
            tweetLikeLabel.text = "\(tweet.favoritesCount/1000000)M"
        }
        else if(tweet.favoritesCount >= 1000) {
            tweetLikeLabel.text = "\(tweet.favoritesCount/1000)K"
        } else {
            tweetLikeLabel.text = "\(tweet.favoritesCount)"
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
                likeButton.setImage(image, forState: .Normal)
            }
        }
        else {
            if let image = UIImage(named: "like-action-on") {
                likeButton.setImage(image, forState: .Normal)
            }
        }

        
        
                // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
    }

    @IBAction func onRetweet(sender: AnyObject) {
        
        if(retweeted == false){
            TwitterClient.sharedInstance.retweet(tweetID)
            retweeted = true
            if let image = UIImage(named: "retweet-action-on") {
                retweetButton.setImage(image, forState: .Normal)
            }
            tweet.retweetCount = tweet.retweetCount + 1
            if(tweet.retweetCount >= 1000000) {
                tweetCountLabel.text = "\(tweet.retweetCount/1000000)M"
            }
            else if(tweet.retweetCount >= 1000) {
                tweetCountLabel.text = "\(tweet.retweetCount/1000)K"
            } else {
                tweetCountLabel.text = "\(tweet.retweetCount)"
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
                tweetCountLabel.text = "\(tweet.retweetCount/1000000)M"
            }
            else if(tweet.retweetCount >= 1000) {
                tweetCountLabel.text = "\(tweet.retweetCount/1000)K"
            } else {
                tweetCountLabel.text = "\(tweet.retweetCount)"
            }
            
        }

    }
    
    
    @IBAction func onLike(sender: AnyObject) {
        
        if(favorited == false) {
            TwitterClient.sharedInstance.favorites(tweetID)
            favorited = true
            if let image = UIImage(named: "like-action-on") {
                likeButton.setImage(image, forState: .Normal)
            }
            tweet.favoritesCount = tweet.favoritesCount + 1
            if(tweet.favoritesCount >= 1000000) {
                tweetLikeLabel.text = "\(tweet.favoritesCount/1000000)M"
            }
            else if(tweet.favoritesCount >= 1000) {
                tweetLikeLabel.text = "\(tweet.favoritesCount/1000)K"
            } else {
                tweetLikeLabel.text = "\(tweet.favoritesCount)"
            }
            
        }
        else {
            TwitterClient.sharedInstance.unfavorite(tweetID)
            favorited = false
            if let image = UIImage(named: "like-action") {
                likeButton.setImage(image, forState: .Normal)
            }
            tweet.favoritesCount = tweet.favoritesCount - 1
            if(tweet.favoritesCount >= 1000000) {
                tweetLikeLabel.text = "\(tweet.favoritesCount/1000000)M"
            }
            else if(tweet.favoritesCount >= 1000) {
                tweetLikeLabel.text = "\(tweet.favoritesCount/1000)K"
            } else {
                tweetLikeLabel.text = "\(tweet.favoritesCount)"
            }
            
            
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
