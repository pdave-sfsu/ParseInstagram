//
//  AddPhotoViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// Parse
import Parse


// FIGURE out way to avoid the addAPhotoButton (TapGestureRecognizer?)
// ADD ERROR MESSAGE: IF IMAGE IS NULL, THEN SAY "PLEASE ADD AN IMAGE"
// Fix Date Format (try to send the actual date for consistency)
// SEGUE (TRANSITION) TO TIMELINE (add animation?)
// Make the text field bigger and nicer


// Posts the photo to Parse
// import UIImagePickerControllerDelegate, UINavigationControllerDelegate
class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addAPhotoButton: UIButton!
    
    @IBOutlet weak var photoCaptionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // specific image being posted
    var image: UIImage?
    
    // caption for the image
    var caption: String?
    
    // timeStamp for post
    var timeStamp: String?
    
    
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
            image = editedImage
        } else {
            image = originalImage
        }
        
        // Change the imageView
        photoImageView.image = image
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    // addAPhotoButton action: Bring up the photo library for user to choose a photo
    @IBAction func addAPhotoButtonPressed(_ sender: Any) {
        
        //Code for choosing an image from the Photo Library
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // submitButton action: lets the user post an image with the caption
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        print("Submit button pressed")
        
        // Retrieve the caption from the photoCaptionTextField
        caption = self.photoCaptionTextField.text
        
        // DateFormatter
        // Temporary solution; in the future, just hold the date in raw form
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm"
        timeStamp = formatter.string(from: Date())
                
        // post created with the image, caption, and date
        let post = Post.init(actualPhoto: image!, photoCaption: caption!, date: timeStamp!)
        
        // sending post to Parse
        // Specifically, creates an object that is saved on Parse servers
        Post.createNewPost(post: post) { (success: Bool, error: Error?) in
            
            // If post was successfully sent
            if success {
                
                print("Photo got posted")
                
                // Changing the tab to timelineViewContoller
                self.tabBarController?.selectedIndex = 0
                // When the timelineViewController is called the viewDidAppear() method will reload the tableView
                
                //Remove the image, imageView, and the textField
                self.image = nil
                self.caption = nil
                self.photoImageView.image = nil
                self.photoCaptionTextField.text = ""
                
                //Error
            } else {
                print("AddPhotoViewController/submitButtonPressed Error: \(error?.localizedDescription)")
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
