//
//  ProfileViewController.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/25/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  var user: User! 

    override func viewDidLoad() {
        super.viewDidLoad()
      
      print("In the profile view")

      tableView.dataSource = self
      tableView.delegate = self
      
      print("User in the Profile View is: \(user.name!)")
      
      tableView.reloadData()
  }

  // MARK: - TABLEVIEW METHODS
  
  func numberOfSections(in tableView: UITableView) -> Int{
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      switch section {
      
        case 0:
          return 1
      
        case 1:
          return 10
      
        default:
          return 0
    }
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch indexPath.section {
      
    case 0:
      return 300
      
    case 1:
      return 50

    default:
      return 44
    }
  }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
  let cell = UITableViewCell()
  
  cell.selectionStyle = .none
  
  if indexPath.section == 0 {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
    cell.user = user
  }

  return cell
}
  
  
 
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
