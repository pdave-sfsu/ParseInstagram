//
//  ProfileViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 3/6/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// Parse
import Parse
import ParseUI


// Let the user change their profile photo
// Change the default photo to a generic image of a person


// ProfileView: User can see their profile
class ProfileViewController: UIViewController {

    // outlets
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileCaptionLabel: UILabel!
    @IBOutlet weak var profileImageView: PFImageView!
    
    
    //viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve the current user
        let currentUser = PFUser.current()
        
        // retrieve the current user fullName Array
        let fullNameArray = currentUser!["fullName"] as? [String]
        // Retrieve first element within the array
        let fullName = fullNameArray?[0]
        
        // retrieve the profile caption
        let profileCaptionArray = currentUser?["profileCaption"] as? [String]
        let profileCaption = profileCaptionArray?[0]
        
        // set the values within the outlets
        userNameLabel.text = currentUser?["username"] as? String
        fullNameLabel.text = fullName
        profileCaptionLabel.text = profileCaption
        
        // retrieve the profilePhoto
        if let profilePhotoArray = currentUser?["profilePhoto"] as? [Any] {
            let profilePhoto = profilePhotoArray[0]
            
            // Setting the profilePhoto to the profileImageView and casting it as a PFFile
            self.profileImageView.file = profilePhoto as? PFFile
            // loadInBackgroun(); MAKE SURE YOU MEMBER THIS
            profileImageView.loadInBackground()
            
        // If profileImage doesn't exist
        } else {
            // Default photo for all users
            profileImageView.image = UIImage(named: "instagram")
        }
        
    }

    
    // Action for when logout Button Pessed
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        // built-in Parse method
        // Logs users out
        PFUser.logOutInBackground { (error: Error?) in
            
            // if no error
            if error == nil {
                
                // performs segue to loginViewController
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
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
