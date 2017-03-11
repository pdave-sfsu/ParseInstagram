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
        
        let currentUser = PFUser.current()
        
        let fullNameArray = currentUser!["fullName"] as? [String]
        
        let fullName = fullNameArray?[0]
        
        let profileCaptionArray = currentUser?["profileCaption"] as? [String]
        
        let profileCaption = profileCaptionArray?[0]
        
        fullNameLabel.text = fullName
        userNameLabel.text = currentUser?["username"] as? String
        profileCaptionLabel.text = profileCaption
        
//        profileImageView.setImageWith(nil, placeholderImage: "instagram")
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
