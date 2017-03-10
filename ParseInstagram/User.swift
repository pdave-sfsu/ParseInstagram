//
//  User.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 3/9/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    
    var fullName: String?
    var userName: String?
    var password: String?
    
    var profilePhoto: UIImage?
    var profileCaption: String?
    
    var user: PFUser?
    
    
    init(fullName: String, userName: String, password: String, profilePhoto: UIImage, profileCaption: String) {
        
        self.fullName = fullName
        self.userName = userName
        self.password = password
        self.profilePhoto = profilePhoto
        self.profileCaption = profileCaption
        
        user = PFUser()
        
        user?.username = userName
        user?.password = password
        user?.add(fullName as Any, forKey: "fullName")
        user?.add(profilePhoto as Any, forKey: "profilePhoto")
        user?.add(profileCaption as Any, forKey: "profileCaption")
        
        
        //Use built-in Parse method to create the user
        user?.signUpInBackground { (success: Bool, error: Error?) in
            
            //If new user created.
            if success {
                
                print("New user created")
                
                //Error
            } else {
                print("LoginViewController/onSignUp Error: \(error!.localizedDescription)")
            }
        }
        
    }

}
