//
//  TweetTextCell.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class TweetTextCell: UITableViewCell {

  
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var tweetDateLabel: UILabel!
  @IBOutlet weak var tweetImage: UIImageView!
  
  var formatter = DateFormatter()
  
  var tweet: Tweet! {
    
    didSet {
      
      tweetTextLabel.text = tweet.text
    
      if let date = tweet?.timestamp {
  
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        tweetDateLabel.text = formatter.string(from: date)
      }
    
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

}
