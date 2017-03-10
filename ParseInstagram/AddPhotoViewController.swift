//
//  AddPhotoViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
//Parse
import Parse

//Posts the photo to Parse
//import UIImagePickerControllerDelegate, UINavigationControllerDelegate
class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addAPhotoButton: UIButton!
    @IBOutlet weak var photoCaptionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //specific image being posted
    var image: UIImage?
    
    var caption: String?
    
    var timeStamp: String?
    
    //viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    //Method to handle choosing an image from the photo library
    //Built into UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        //Set edited image to the global image property
        if let editedImage = editedImage {
            image = editedImage
        } else {
            image = originalImage
        }
        
        //Change the imageView
        photoImageView.image = image
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    //Bring up the photo library for user to choose a photo
    @IBAction func addAPhotoButtonPressed(_ sender: Any) {
        
        //Code for choosing an image from the Photo Library
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //submit Button action: lets the user post an image with the caption
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        print("Submit button pressed")
        
        caption = self.photoCaptionTextField.text
        
        self.photoCaptionTextField.text = ""
        
        //ADD ERROR MESSAGE: IF IMAGE IS NULL, THEN SAY "PLEASE ADD AN IMAGE"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timeStamp = formatter.string(from: Date())
        
        print(timeStamp)
        
        
        let post = Post.init(actualPhoto: image!, photoCaption: caption!, date: timeStamp!)
        
        
        Post.createNewPost(post: post) { (success: Bool, error: Error?) in
            
            if success {
                
                print("Photo got posted")
                
                //SEGUE (TRANSITION) TO TIMELINE
                
                self.tabBarController?.selectedIndex = 0
                
                
                //Figure out way to refresh the timeline
                //                var timelineViewControllerCopy = UIViewController() as! TimelineViewController
                //
                //                timelineViewControllerCopy.refreshControlAction(timelineViewControllerCopy.refreshControl)
                
                self.image = nil
                
                self.photoImageView.image = nil
                
            } else {
                print("AddPhotoViewController/submitButtonPressed Error: \(error?.localizedDescription)")
            }
            
        }
        
        
        
        //built-in Parse method that posts the image
        //Specifically, creates an object that is saved on Parse servers
//        Post.postUserImage(image: image, withCaption: caption) { (success: Bool, error: Error?) in
//            
//            //If success
//            if success {
//                print("Photo got posted")
//                
//                //SEGUE (TRANSITION) TO TIMELINE
//                
//                self.tabBarController?.selectedIndex = 0
//                
//                
//                //Figure out way to refresh the timeline
////                var timelineViewControllerCopy = UIViewController() as! TimelineViewController
////                
////                timelineViewControllerCopy.refreshControlAction(timelineViewControllerCopy.refreshControl)
//                
//                self.image = nil
//                
//                self.photoImageView.image = nil
//                
//            //Error
//            } else {
//                print("AddPhotoViewController/submitButtonPressed Error: \(error?.localizedDescription)")
//            }
//        }
        
        
        
    }
    

    
    
    //Never needed to resize image and seems to work fine without it
//    func resize(image: UIImage, newSize: CGSize) -> UIImage {
//        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
//        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
//        resizeImageView.image = image
//        
//        UIGraphicsBeginImageContext(resizeImageView.frame.size)
//        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
    
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
