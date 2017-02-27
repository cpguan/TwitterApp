//
//  TweetCell.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
    
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var dateTextLabel: UILabel!
  
  @IBOutlet weak var replyButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var profileButton: UIButton!
  
  
  var favStatus: Bool?
  var favCount: Int?
  var retweetStatus: Bool?
  var rtCount: Int?
  var originalTweetID: String?
  var retweetID: String?
  
  var dateFormatter = DateFormatter()

  let calendar = NSCalendar.current
  let currentDate = Date()
  
  
  var tweet: Tweet! {
    
    didSet {
  
      tweetTextLabel.text = tweet.text
  
      nameLabel.text = tweet.user?.name!
      screenNameLabel.text = ("@" + (tweet.user?.screenname!)!)
      
      if let profileUrl = tweet.user?.profileUrl {
        profileImage.setImageWith(profileUrl)
      }
      
      if let date = tweet?.timestamp {
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short

        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = DateComponentsFormatter.UnitsStyle.short
        dateComponentsFormatter.allowedUnits = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute]  // full example, will shorten based on time interval
  
        let oneDayAgo = Date(timeIntervalSinceNow: -60 * 60 * 24)
        let oneHourAgo = Date(timeIntervalSinceNow: -60*60)
        
        if date.timeIntervalSinceReferenceDate > oneHourAgo.timeIntervalSinceReferenceDate {
      
          dateComponentsFormatter.allowedUnits = [NSCalendar.Unit.minute]
          let minutesDifference = dateComponentsFormatter.string(from: date, to: currentDate)
          dateTextLabel.text = minutesDifference! + " ago"
  
        } else if date.timeIntervalSinceReferenceDate > oneDayAgo.timeIntervalSinceReferenceDate {
          dateComponentsFormatter.allowedUnits = [NSCalendar.Unit.hour]
          let hourDifference = dateComponentsFormatter.string(from: date, to: currentDate)
          print("hour diff: \(hourDifference!)")
          dateTextLabel.text = hourDifference! + " ago"
          
        } else {
          dateTextLabel.text = dateFormatter.string(from: date)
        }
        
      }
      
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
      
      favoriteCountLabel.text = String(describing: favCount!)
      retweetCountLabel.text = String(describing: rtCount!)
      
      favStatus = tweet.favorited!
      retweetStatus = tweet.retweeted!
    
      setLabels()
  
    }
  }


    override func awakeFromNib() {
        super.awakeFromNib()
      
      profileImage.layer.cornerRadius = 3
      profileImage.clipsToBounds = true
      
    }
  
  
     override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
  
  
  @IBAction func onSave(_ sender: UIButton) {
    
    print("Clicked on Save/Unsave")
    
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
        self.favoriteCountLabel.text = String(describing: self.favCount!)
        self.favoriteCountLabel.textColor = UIColor.red
        self.saveButton.setImage(#imageLiteral(resourceName: "unsave_redFill16"), for: .normal)
        
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
        self.favoriteCountLabel.text = String(self.favCount!)
        self.favoriteCountLabel.textColor = UIColor.darkGray
        self.saveButton.setImage(#imageLiteral(resourceName: "save_greyFill16"), for: .normal)
        
      }, failure: { (error: Error) -> () in
        print("Error: \(error.localizedDescription)")
      })
    }
    
  }
  
  

  
  @IBAction func onRetweet(_ sender: Any) {
    
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
        self.retweetCountLabel.text = String(describing: self.rtCount!)
        self.retweetCountLabel.textColor = UIColor(red:0.05, green:0.87, blue:0.11, alpha:1.0)
        self.retweetButton.setImage(#imageLiteral(resourceName: "retweetGreenFill16"), for: .normal)
        
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
      self.retweetCountLabel.text = String(describing: self.rtCount!)
      self.retweetCountLabel.textColor = UIColor.darkGray
      self.retweetButton.setImage(#imageLiteral(resourceName: "retweet_greyFill16"), for: .normal)

      print("Un-retweeting the Tweet. Retweet count is now \(self.rtCount!)")
      
    } , failure: { (error: Error) -> () in
      print("Error: \(error.localizedDescription)")
    })
  }
  
  
  // MARK: - REPLY TO TWEET 
  
 
  @IBAction func onReply(_ sender: UIButton) {
    print("Clicked on Reply")
    
  }
  
  
  // MARK: - LAYOUT FOR FAVORITES AND RETWEETS
  

  func setLabels() {
  
    if tweet.favorited! {
      self.favoriteCountLabel.textColor = UIColor.red
      self.saveButton.setImage(#imageLiteral(resourceName: "unsave_redFill16"), for: .normal)
    } else if tweet.favorited == false {
      self.favoriteCountLabel.textColor = UIColor.darkGray
      self.saveButton.setImage(#imageLiteral(resourceName: "save_greyFill16"), for: .normal)
    }
    
    if tweet.retweeted! {
      self.retweetCountLabel.textColor = UIColor(red:0.05, green:0.87, blue:0.11, alpha:1.0)
      self.retweetButton.setImage(#imageLiteral(resourceName: "retweetGreenFill16"), for: .normal)
      
    } else if tweet.retweeted == false {
      self.retweetCountLabel.textColor = UIColor.darkGray
      self.retweetButton.setImage(#imageLiteral(resourceName: "retweet_greyFill16"), for: .normal)
    }
    
    self.replyButton.setImage(#imageLiteral(resourceName: "reply_grey16"), for: .normal)
    self.replyButton.setImage(#imageLiteral(resourceName: "reply_tweetBlue16"), for: .highlighted)
    
  }
  

  }



  

