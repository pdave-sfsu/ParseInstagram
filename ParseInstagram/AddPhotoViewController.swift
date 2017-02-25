//
//  AddPhotoViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addAPhotoButton: UIButton!
    @IBOutlet weak var photoCaptionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        image = originalImage
        
        photoImageView.image = image
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addAPhotoButtonPressed(_ sender: Any) {
        
        print("Add a photo button pressed")
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        print("Submit button pressed")
        
        Post.postUserImage(image: image, withCaption: photoCaptionTextField.text) { (success: Bool, error: Error?) in
            
            if success {
                print("Photo got posted")
            } else {
                print("Photo error!")
            }
        }
        
        
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
