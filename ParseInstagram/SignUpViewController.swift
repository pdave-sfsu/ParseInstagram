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
class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // outlets
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileCaptionTextField: UITextField!
    
    // ImageView and button
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    // global property to hold the profileImage
    var profileImage: UIImage?
    

    // viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // Method to handle choosing an image from the photo library
    // Built into UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // If editedImage exists, set edited image to the global image property
        // Else set the originalImage to global image property
        if let editedImage = editedImage {
            profileImage = editedImage
        } else {
            profileImage = originalImage
        }
        
        // Change the imageView with profileImage
        profileImageView.image = profileImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    // addProfileImageButton action: Bring up the photo library for user to choose a photo
    @IBAction func addProfileImageButton(_ sender: Any) {
        
        //Code for choosing an image from the Photo Library
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
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
        
        // Must create new keys
        // Values within keys will be stored as arrays
        newUser.add(fullName as Any, forKey: "fullName")
        newUser.add(profileCaption as Any, forKey: "profileCaption")
        
        let profileImagePFF = Post.getPFFileFromImage(image: profileImage)
        newUser.add(profileImagePFF as Any, forKey: "profilePhoto")
        
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
