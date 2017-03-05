//
//  Tweet.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  
  var user: User?
  var text: String?
  var timestamp: Date?
    
  var retweetCount: Int? = 0
  var favoritesCount: Int? = 0
    
  var favorited: Bool?
  var retweeted: Bool?
  var id: NSNumber?
  var idStr: String?
    
  var retweetedStatus: NSDictionary?
  var currentUserRetweet: NSDictionary?
  
  init(dictionary: NSDictionary){
  
    user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
    
    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
    favorited = dictionary["favorited"] as? Bool
    retweeted = dictionary["retweeted"] as? Bool
    
    let timestampString = dictionary["created_at"] as? String

    if let timestampString = timestampString {
      let formatter = DateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.date(from: timestampString)
    }
    
    id = dictionary["id"] as? Int as NSNumber?
    idStr = dictionary["id_str"] as? String

    retweetedStatus = dictionary["retweeted_status"] as? NSDictionary
    currentUserRetweet = dictionary["current_user_retweet"] as? NSDictionary

    }

  
  //MARK: - Convenience Methods
  
  // This method gives us tweets as an array of dictionaries
  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
  
      var tweets = [Tweet]()
    
      for dictionary in dictionaries {
        let tweet = Tweet(dictionary: dictionary)
        tweets.append(tweet)
        
      }
    
      return tweets
  }
  
  // This method converts a dictionary into a single tweet 
  class func tweetAsDictionary(_ dict: NSDictionary) -> Tweet {
   
    let tweet = Tweet(dictionary: dict)
    
    return tweet
  }

}
