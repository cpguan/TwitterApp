//
//  RetweetFavCell.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class RetweetFavCell: UITableViewCell {

  
  @IBOutlet weak var favCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  
  var rtCount: Int!
  var favCount: Int!
  var originalTweetID: String?
  var favStatus: Bool!
  
  var tweet: Tweet! {
    
    didSet {
      
      if tweet.retweetedStatus != nil {
        let retweet = Tweet.tweetAsDictionary(tweet.retweetedStatus!)
        originalTweetID = retweet.idStr
        favCount = retweet.favoritesCount
        rtCount = retweet.retweetCount
        
      } else {
        originalTweetID = tweet.idStr
        favCount = tweet.favoritesCount
        rtCount = tweet.retweetCount
      }
      
      retweetCountLabel.text = String(describing: rtCount!)
      favCountLabel.text = String(describing: favCount!)
      favStatus = tweet.favorited!

    }
    
  }
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  @IBAction func favCountButton(_ sender: UIButton) {
    print("Pressed on Likes")
    
  }
  
  
  @IBAction func retweetCountButton(_ sender: UIButton) {
    print("Pressed on Retweets")
  }
  
}
