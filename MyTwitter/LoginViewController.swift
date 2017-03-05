//
//  LoginViewController.swift
//  MyTwitter
//
//  Created by Pan Guan on 2/19/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

  
  
  @IBOutlet weak var loginButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 4
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
  
  @IBAction func onLoginButton(_ sender: Any) {
    
    TwitterClient.sharedInstance.login(success: {
      
      print("logged in!")
      self.performSegue(withIdentifier: "loginSegue", sender: nil)
      
    }) { (error: Error) in
      print("Error: \(error.localizedDescription)")
    }
   
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
