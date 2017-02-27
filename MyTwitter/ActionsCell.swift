//
//  ActionsCell.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class ActionsCell: UITableViewCell {

  
  @IBOutlet weak var favButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
 
  var originalTweetID: String?
  var favStatus: Bool!
  var favCount: Int!
  var retweetStatus: Bool!
  var rtCount: Int!
  
  var tweet: Tweet! {
    
    didSet {
      
      if tweet.retweetedStatus != nil {
        let retweet = Tweet.tweetAsDictionary(tweet.retweetedStatus!)
        originalTweetID = retweet.idStr
        
      } else {
        originalTweetID = tweet.idStr
      }
      
      favStatus = tweet.favorited!
      retweetStatus = tweet.retweeted!
      
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
 
      setLabels()
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
  
  
  // MARK: - SAVE AS FAVORITE
  
  
  @IBAction func onFavorite(_ sender: UIButton) {
    print("pressed on Favorite")
    if favStatus == false {
      
      TwitterClient.sharedInstance.createFav(params: ["id": tweet.idStr!], success: { (tweet) -> () in
        
        if (tweet?.retweetedStatus) != nil {
          let retweet = Tweet.tweetAsDictionary((tweet?.retweetedStatus!)!)
          self.favCount = retweet.favoritesCount
        } else {
          self.favCount = tweet?.favoritesCount
        }
        
        
        print("Saving TweetID: \(self.originalTweetID!) to favorites. New Status is: \(tweet!.favorited!).  FavCount is: \(self.favCount!)")
        self.favStatus = true
        self.favButton.setImage(#imageLiteral(resourceName: "unSave24"), for: .normal)
        
//        let cell = UITableViewCell() as! RetweetFavCell
//          var count = cell.favCount!
//          count += 1
//          cell.favCountLabel.text = String(describing: count)
        
  
      }, failure: { (error: Error) -> () in
        print("Could not successfully save tweet.  Error: \(error.localizedDescription)")
      })
    }
      
    else if favStatus == true {
      
      TwitterClient.sharedInstance.unSaveAsFavorite(params: ["id": originalTweetID!], success: { (tweet) -> () in
        
        if (tweet?.retweetedStatus) != nil {
          let retweet = Tweet.tweetAsDictionary((tweet?.retweetedStatus!)!)
          self.favCount = retweet.favoritesCount
          
        } else {
          self.favCount = tweet?.favoritesCount
        }
        
        print("Removing from favorites.  Status after unsaving: \(self.favCount!)")
        self.favStatus = false
        self.favButton.setImage(#imageLiteral(resourceName: "addSaveGrey24"), for: .normal)
        
      }, failure: { (error: Error) -> () in
        print("Error: \(error.localizedDescription)")
      })
    }
  }
  
  // MARK: -  RETWEET
  
  @IBAction func onRetweet(_ sender: UIButton) {
    
    print("Clicked on Retweet Button")
    
    if retweetStatus == false {
      
      TwitterClient.sharedInstance.retweet(params: ["id": originalTweetID!], success: { (tweet) -> () in
        
        if (tweet?.retweetedStatus) != nil {
          let retweet = Tweet.tweetAsDictionary((tweet?.retweetedStatus!)!)
          self.rtCount = retweet.retweetCount
        } else {
          self.rtCount = tweet?.retweetCount
        }
        
        print("Retweeting the Tweet. Retweet count is now \(self.rtCount!)")
        
        self.retweetStatus = true
        self.retweetButton.setImage(#imageLiteral(resourceName: "retweetGreenFill24"), for: .normal)
        
      } , failure: { (error: Error) -> () in
        print("Error: \(error.localizedDescription)")
      })
      
    } else if retweetStatus == true {
      
      performUnRetweet()
    }

    
  }

  
  func performUnRetweet() {
    
    TwitterClient.sharedInstance.unRetweet(params: ["id": originalTweetID!], success: { (unretweeted) -> () in
      
      self.retweetStatus = false
      self.rtCount = (unretweeted?.retweetCount)!-1
      self.retweetButton.setImage(#imageLiteral(resourceName: "retweetGreyFill24"), for: .normal)
      
      
    } , failure: { (error: Error) -> () in
      print("Error: \(error.localizedDescription)")
    })
  }
   

  
// MARK: - REPLY

  @IBAction func onReply(_ sender: UIButton) {
    print("pressed on reply")
  }
  
  
  // MARK: - SET LABELS
  
  func setLabels() {
    
    if tweet.favorited! {
        self.favButton.setImage(#imageLiteral(resourceName: "unSave24"), for: .normal)
    } else if tweet.favorited == false {
      self.favButton.setImage(#imageLiteral(resourceName: "addSaveGrey24"), for: .normal)
    }
    
    if tweet.retweeted! {
      self.retweetButton.setImage(#imageLiteral(resourceName: "retweetGreenFill24"), for: .normal)
      
    } else if tweet.retweeted == false {
      self.retweetButton.setImage(#imageLiteral(resourceName: "retweetGreyFill24"), for: .normal)
    }
    
  }
  
  
  

}
