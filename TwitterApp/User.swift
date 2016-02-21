//
//  User.swift
//  TwitterApp
//
//  Created by macbookair11 on 2/20/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:  String?
    var screenname: NSString?
    var profileUrl: String?
    var tagline: String?
    
    var dictionary : NSDictionary?
    
    static let UserDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        

       
            profileUrl = dictionary["profile_image_url_https"] as? String
        
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
    
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
        
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
                
                }
            
                return _currentUser
            }
        set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
            }
     
        }
}
