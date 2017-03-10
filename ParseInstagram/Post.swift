//
//  Post.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
//Parse
import Parse

//This class is meant to send posts to Parse
class Post: NSObject {
    
    var fullName: String?
    var userName: String?
    var profilePhoto: UIImage?
    
    var actualPhoto: UIImage?
    var photoCaption: String?
    var date: String?
    
    
    init(actualPhoto: UIImage, photoCaption: String, date: String) {
        
        self.actualPhoto = actualPhoto
        self.photoCaption = photoCaption
        self.date = date
        
        let user = PFUser.current()
        print(user)
//        fullName = user?["fullName"] as! String?
        print("fullName")
        print(fullName)
//        userName = user?.username
        //        profilePhoto =
        
    }
    
    
    class func createNewPost(post: Post, withCompletion completion: PFBooleanResultBlock?) {
        
        print()
        
        let newPost = PFObject(className: "Post")
        newPost["actualPhoto"] = getPFFileFromImage(image: post.actualPhoto)
        newPost["photoCaption"] = post.photoCaption
        newPost["date"] = post.date
        
        print(newPost)
        
        
        let user = PFUser.current()
        
        print(user)
        
        newPost["fullName"] = user!["fullName"]
        
        print(newPost)
        
        newPost["userName"] = user!["username"]
//        newPost["profilePhoto"] = getPFFileFromImage(image: post.profilePhoto)
        
        
        
        print(newPost)

        newPost.saveInBackground(block: completion)
        
    }
    
    //adds user post to Parse.
    //Parameters are image, caption, and completion block
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image)
        post["author"] = PFUser.current()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        
        
        post["username"] = PFUser.current()?.username
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
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
