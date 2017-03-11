//
//  SignUpViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 3/9/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// Parse
import Parse


// Add Cancel button
// Fix transition between the loginViewController and the SignUpViewController (consider navigation controller)


// Sign Up Page
class SignUpViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileCaptionTextField: UITextField!
    

    // viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // SignUpButton action: Signs up a new user
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        // Extracted the paramters of the user
        let fullName = fullNameTextField.text
        let userName = userNameTextField.text
        let password = passwordTextField.text
        let profileCaption = profileCaptionTextField.text
        
        // Created a new User of type PFUser()
        let newUser = PFUser()
        
        // set the parameters of the new user
        // Added new keys where necessary
        newUser.username = userName
        newUser.password = password
        newUser.add(fullName as Any, forKey: "fullName")
        newUser.add(profileCaption as Any, forKey: "profileCaption")
        //        newUser?.add(profilePhoto as Any, forKey: "profilePhoto")
        
        //Use built-in Parse method to create the user
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            //If new user created.
            if success {
                
                print("SignUpViewController/signUpButtonPressed(): New user created")
                
                // Segues to the TimelineViewController
                self.performSegue(withIdentifier: "loginSegueFromSignUp", sender: nil)
                
                //Error
            } else {
                print("LoginViewController/onSignUp Error: \(error!.localizedDescription)")
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
