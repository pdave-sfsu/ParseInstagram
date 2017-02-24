//
//  User.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    
    //Stores the current user
    static var _currentUser: User?
    
    //class variable to get and set the current user; may be nil
    class var currentUser: User? {
        
        get {
            if _currentUser == nil {
                
                //userDefault to store the value of current user across restarts
                let userDefault = UserDefaults.standard
                
                //retrieve the previous current user
                _currentUser = userDefault.object(forKey: "currentUserData") as? User
                
            }
            return _currentUser
        }
        
        //setting a current user
        set(user) {
            
            //Sets currentUser with new user
            _currentUser = user
            
            //initialize userDefaults
            let userDefault = UserDefaults.standard
            
            //Safely unwrapping user
            if let user = user {
                
                //Saving the userData with key in UserDefaults
                userDefault.set(user, forKey: "currentUserData")
                
                //if user is empty
            } else {
                
                //Saving nil with key in userDefaults
                userDefault.set(nil, forKey: "currentUserData")
            }
            
            //synchronize() method saves the data
            userDefault.synchronize()
        }
    }

}
