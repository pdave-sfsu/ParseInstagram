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
