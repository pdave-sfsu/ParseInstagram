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


// Let the user change their profile photo


// ProfileView: User can see their profile
class ProfileViewController: UIViewController {

    // outlets
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileCaptionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
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
        
        // Temporary profileImage
        profileImageView.image = UIImage(named: "instagram")
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
