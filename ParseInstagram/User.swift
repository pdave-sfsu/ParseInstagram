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
    
    var newUser: PFUser?
    
    
    init(fullName: String, userName: String, password: String, profilePhoto: UIImage?, profileCaption: String) {
        
        self.fullName = fullName
        self.userName = userName
        self.password = password
        self.profilePhoto = profilePhoto
        self.profileCaption = profileCaption
        
        newUser = PFUser()
        
        newUser?.username = userName
        newUser?.password = password
        newUser?.add(fullName as Any, forKey: "fullName")
        newUser?.add(profilePhoto as Any, forKey: "profilePhoto")
        newUser?.add(profileCaption as Any, forKey: "profileCaption")
        
        
        
        
    }
    
    class func logInUser(user: User?) {
        
        PFUser.logInWithUsername(inBackground: (user?.userName)!, password: (user?.password)!) { (user: PFUser?, error: Error?) -> Void in
            
            if user != nil {
                print("You're logged in!")
                
            } else {
                print("LoginViewController/onSignIn Error: \(error?.localizedDescription)")
            }
        }
    }

}
