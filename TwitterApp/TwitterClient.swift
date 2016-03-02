//
//  TwitterClient.swift
//  TwitterApp
//
//  Created by macbookair11 on 2/20/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "vFUdlMV2QCgwooBNSnJh3q7bO";
let twitterConsumerSecret = "iPiiJBWpZzoEdOIHg7ljznK83DUwMWNauAa4v2UJV3E5WYoW2R";
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    
    
    static var sharedInstance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret )
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {

        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as? [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries!)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
               failure(error)
        })
        
    }
    
    func login(sucess: () -> (), failure: (NSError) -> ()){
        loginSuccess = sucess
        loginFailure = failure
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterapp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Success!!!")
            let authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(authURL)
            }) { (error: NSError!) -> Void in
                print("Error didnt get token")
                self.loginFailure?(error)
        }
        

    
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.UserDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            
            self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
                })
            }) { (error: NSError!) -> Void in
                self.loginFailure?(error)
        }
    
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
           
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

        
            }
    
    func retweet(id: String) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("retweet")
            }) { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("\(error.localizedDescription)")
        }
    }
    
    func unretweet(id: String) {
        POST("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (operation:NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("unretweet")
            }) { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("\(error.localizedDescription)")
        }
    }
    
    func favorites(id: String) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("favorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("\(error.localizedDescription)")
        }
    }
    
    func unfavorite(id: String) {
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("unfavorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("\(error.localizedDescription)")
        }
    }


    
}
