//
//  ProfileCell.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/22/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
  
  @IBOutlet weak var locationIcon: UIImageView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var profileBanner: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var tagLineLabel: UILabel!
  @IBOutlet weak var followersCountLabel: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet weak var tweetCountLabel: UILabel!
  @IBOutlet weak var favoritesCountLabel: UILabel!
  
  
  var user: User! {
    
    didSet {
      
      nameLabel.text = user?.name!
      screenNameLabel.text = ("@" + (user?.screenname!)!)
      followersCountLabel.text = String(describing: user.followingCount!)
      followingCountLabel.text = String(describing: user.followersCount!)
      tweetCountLabel.text = String(describing: user.tweetCount!)
      favoritesCountLabel.text = String(describing: user.favoriteCount!)

      if let profileUrl = user?.profileUrl {
        profileImage.setImageWith(profileUrl)
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
      }
      
      if let profileBannerUrl = user?.profileBannerUrl {
        profileBanner.setImageWith(profileBannerUrl)
      }
      
      if let tagline = user?.tagline {
        tagLineLabel.text = tagline
      }
      
      if let location = user?.location {
        locationLabel.text = location
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
  
  @IBAction func getFollowers(_ sender: UIButton) {
    print("Get followers")
  }
  
  
  @IBAction func getFollowing(_ sender: UIButton) {
    print("Get following")
  }
  
  
  @IBAction func getFavoriteTweets(_ sender: UIButton) {
    print("Get favorites")
  }
  
  @IBAction func getTweets(_ sender: UIButton) {
    print("Get tweets") 
  }
  
  

}
