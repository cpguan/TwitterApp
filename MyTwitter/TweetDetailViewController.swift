//
//  TweetDetailViewController.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/25/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailCellDelegator {

  
  @IBOutlet weak var tableView: UITableView!
  
  var tweet: Tweet!
  var replies: [Tweet]!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationItem.title = "Detail"
      
      tableView.dataSource = self
      tableView.delegate = self
      
      tableView.estimatedRowHeight = 200
      tableView.rowHeight = UITableViewAutomaticDimension
      
      tableView.reloadData()
      
  }
  
  // MARK: - TABLEVIEW LOADING METHODS
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    switch section {
      
    case 0, 1, 2, 3:
      return 1
      
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   

    
    switch indexPath.section {
      
    case 0:
      return 65
    
    case 1:
      return 200
      
    case 2,3:
      return 50
      
    default:
      return 44
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()
    cell.selectionStyle = .none
    
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
      cell.delegate = self 
      cell.tweet = tweet
    }
    
    if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTextCell", for: indexPath) as! TweetTextCell
      cell.tweet = tweet
    }
    
    if indexPath.section == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "RetweetFavCell", for: indexPath) as! RetweetFavCell
      cell.tweet = tweet
    }
    
    if indexPath.section == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ActionsCell", for: indexPath) as! ActionsCell
      cell.tweet = tweet 
    }
    
    cell.contentView.setNeedsLayout()
    cell.contentView.layoutIfNeeded()

    return cell
  }
  
  func callSegueFromCell(myData dataobject: User) {
    let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileView") as! ProfileViewController
    let userToSend = dataobject
    profileVC.user = userToSend
    self.navigationController?.pushViewController(profileVC, animated: true)
    
  }
  
  @IBAction func composeTweet(_ sender: UIBarButtonItem) {
    print("Going to compose tweet") 
  }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if segue.identifier == "ReplyTweet"{
        
        print("About to Reply to the Tweet")
        
        let replyNavVC = segue.destination as? UINavigationController
        let replyVC = replyNavVC?.viewControllers.first as! ComposeTweetViewController
        replyVC.replyTweet = tweet
        replyVC.isReply = true
        
      }
    }
  

}
