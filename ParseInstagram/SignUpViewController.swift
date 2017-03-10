//
//  SignUpViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 3/9/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
import Parse
import Dispatch

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileCaptionTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        let fullName = fullNameTextField.text
        let userName = userNameTextField.text
        let password = passwordTextField.text
        let profileCaption = profileCaptionTextField.text
        
        var user: User?
        
        user = User(fullName: fullName!, userName: userName!, password: password!, profilePhoto: nil, profileCaption: profileCaption!)
        
        
        var newUser = PFUser()
        
        newUser.username = userName
        newUser.password = password
        newUser.add(fullName as Any, forKey: "fullName")
//        newUser?.add(profilePhoto as Any, forKey: "profilePhoto")
        newUser.add(profileCaption as Any, forKey: "profileCaption")
        
        
        
        //Use built-in Parse method to create the user
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            //If new user created.
            if success {
                
                print("New user created")
                
                self.performSegue(withIdentifier: "loginSegueFromSignUp", sender: nil)

                
                //Error
            } else {
                print("LoginViewController/onSignUp Error: \(error!.localizedDescription)")
            }
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
