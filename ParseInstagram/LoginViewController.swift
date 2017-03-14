//
//  LoginViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/23/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//


// Add an alert if the user enters empty text for password or username: CHECK FOR BOTH
// ALERTS for incorrect username or password
// All alerts for error codes in Parse
// Change name of SignIn action to logIn action


import UIKit
// Parse
import Parse

// First viewController/ Login screen
class LoginViewController: UIViewController {

    // username and password Text Fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
        
    // ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // When "Log in" button is pressed
    @IBAction func onSignIn(_ sender: Any) {
        
        // Extracting the username and password from the textField
        let username = usernameField.text!
        let password = passwordField.text!
        
        // Checking to see is the username and password are empty.
        if username == "" {
            print("Username field is empty")
            
        } else if password == "" {
            print("Password field is empty")
            
        // If username and password are not empty, then sign in
        } else {
            
            // Parse built-in method to log in an existing user. Sends username and password
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                
                // If user is not empty, it means that they user logged in
                if user != nil {
                    
                    // Segue to timeline
                    self.performSegue(withIdentifier: "loginSegueFromLogin", sender: nil)
                    
                    // Error
                } else {
                    print("LoginViewController/onSignIn() Error: \(error?.localizedDescription)")
                }
            }
        }
    }

    
    // When "Sign Up" button is pressed
    @IBAction func onSignUp(_ sender: Any) {
        
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
