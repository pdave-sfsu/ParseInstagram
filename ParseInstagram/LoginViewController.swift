//
//  LoginViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/23/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
//Parse
import Parse


//Add an alert if the user enters empty text for password or username: CHECK FOR BOTH
//ALERTS for incorrect username or password


//First viewController/ Login screen
class LoginViewController: UIViewController {

    //username and password Text Fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
        
    //ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //When "Sign in" button is pressed
    @IBAction func onSignIn(_ sender: Any) {
        
        //Parse built-in method to log in an existing user. Sends username and password
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            
            //If user is not empty, it means that they user logged in
            if user != nil {
                
                //Segue to timeline
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
                
            //Error
            } else {
                print("LoginViewController/onSignIn Error: \(error?.localizedDescription)")
            }
        }
    }

    
    //When "Sign Up" button is pressed
    @IBAction func onSignUp(_ sender: Any) {
        
        //Create the new user
        let newUser = PFUser()
        
        //Set the username and password
        //parse with automatically hash the password, so they are secure
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.add("HALLO" as Any, forKey: "tempKey")
        
        //Use built-in Parse method to create the user
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            //If new user created.
            if success {
                
                //Segue to timeline
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
                //Error
            } else {
                print("LoginViewController/onSignUp Error: \(error!.localizedDescription)")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
