//
//  User.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 3/9/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// Parse
import Parse


// Use this model to sign in the User


// User model; Type NSObject
class User: NSObject {
    
    // properties
    var fullName: String?
    var userName: String?
    var password: String?
    var profileCaption: String?
    var profilePhoto: UIImage?
    
    
    // init 
    init(fullName: String, userName: String, password: String, profilePhoto: UIImage?, profileCaption: String) {
        
        self.fullName = fullName
        self.userName = userName
        self.password = password
        self.profilePhoto = profilePhoto
        self.profileCaption = profileCaption
        
    }
    
    
    // logInUser
    class func logInUser(user: User?) {
        
        // log in the user
        PFUser.logInWithUsername(inBackground: (user?.userName)!, password: (user?.password)!) { (user: PFUser?, error: Error?) -> Void in
            
            // if user is not nil, then they're signed in
            if user != nil {
                print("User/logInUser(): You're logged in!")
                
                //Error
            } else {
                print("User/logInUser() Error: \(error?.localizedDescription)")
            }
        }
    }

}
