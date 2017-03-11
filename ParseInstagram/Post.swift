//
//  Post.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// Parse
import Parse


// ADD profile Photo


// This class is meant to send posts to Parse; type NSObject
// Contains the data schema for the Post object
class Post: NSObject {
    
    // Properties representing the user
    // Had to change the fullName and userName to Any, not String
    var fullName: Any?
    var userName: Any?
    var profilePhoto: UIImage?
    
    // Properties representing the post
    var actualPhoto: UIImage?
    var photoCaption: String?
    var date: String?
    
    
    // Initializes the properties of the Post
    init(actualPhoto: UIImage, photoCaption: String, date: String) {
        
        // Setting properties of post
        self.actualPhoto = actualPhoto
        self.photoCaption = photoCaption
        self.date = date
        
        // Setting properties of user
        // Retrieving the information for current user
        let user = PFUser.current()
        
        // If fullName exists, then save it
        if let fullNameExists = user!["fullName"] {
            fullName = fullNameExists
        }
        
        // If userName exists, then save it
        if let userNameExists = user!["username"] {
            userName = userNameExists
        }
        
    }
    
    
    // createNewPost: uses the Post to create postObject and send it to Parse
    class func createNewPost(post: Post, withCompletion completion: PFBooleanResultBlock?) {
        
        // create newPost as a PFObject; class Post
        let newPost = PFObject(className: "Post")
        
        // save the actualPhoto, photoCaption, and date as keys
        // Cast the actualPhoto as a PFFile
        newPost["actualPhoto"] = getPFFileFromImage(image: post.actualPhoto)
        newPost["photoCaption"] = post.photoCaption
        newPost["date"] = post.date
        
        // save the fullName and userName
        newPost["fullName"] = post.fullName
        newPost["userName"] = post.userName
        
        // save in background; save to Parse
        newPost.saveInBackground(block: completion)
        
    }
    

    //Converts the UIImage to PFFile
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        
        // check if image is not nil
        if let image = image {
            
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                
                //returns file
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
