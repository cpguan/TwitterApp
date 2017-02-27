//
//  User.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class User: NSObject {
  
  var name: String?
  var screenname: String?
  var profileUrl: URL?
  var tagline: String?
  var followersCount: Int?
  var followingCount: Int?
  var profileBannerUrl: URL?
  var location: String?
  var favoriteCount: Int?
  var tweetCount: Int?
  
  var dictionary: NSDictionary?
  
  init(dictionary: NSDictionary) {
    
    self.dictionary = dictionary
    
    name = dictionary["name"] as? String
    screenname = dictionary["screen_name"] as? String
    favoriteCount = dictionary["favourites_count"] as? Int
    tweetCount = dictionary["statuses_count"] as? Int
    
    if let profileUrlString = dictionary["profile_image_url_https"] as? String {
      profileUrl = URL(string: profileUrlString)
    }
    
    if let profileBannerUrlString = dictionary["profile_banner_url"] as? String{
      profileBannerUrl = URL(string: profileBannerUrlString)
    }
    
    location = dictionary["location"] as? String
    tagline = dictionary["description"] as? String
    followersCount = dictionary["followers_count"] as? Int
    followingCount = dictionary["friends_count"] as? Int
    
  }
    
  static let userDidLogoutNotification = "UserDidLogout"
  static var _currentUser: User?
  
  class var currentUser: User? {
    
      get {
        
        if _currentUser == nil{
          let defaults = UserDefaults.standard
          let userData = defaults.object(forKey: "currentUserData") as? Data
          
          if let userData = userData{
            print("I found data cached")
            if let dictionary = try? JSONSerialization.jsonObject(with: userData, options: .allowFragments){
              print("I deserialized the data")
              _currentUser = User(dictionary: dictionary as! NSDictionary)
            }
          }
        }
        return _currentUser
    }

    
    set(user) {
      _currentUser = user
      
      let defaults = UserDefaults.standard
      
      if let user = user {
        let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
        defaults.set(data, forKey: "currentUserData")
      } else {
        defaults.set(nil, forKey: "currentUserData")
      }
  
      
      defaults.synchronize()
      
    }
    
    
  }
  
  
  
  
}
