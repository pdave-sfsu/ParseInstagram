//
//  InstagramPost.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// import Parse and ParseUI
import Parse
// ParseUI is used for images
import ParseUI


// Make the section header using storyboard


// cell for Timeline tableView
// Each instagramPost has an imageView, caption, and a date
// Section header is not included
class InstagramPost: UITableViewCell {

    // outlets
    // pictureImageView is of type PFImageView, not UIImageView
    @IBOutlet weak var pictureImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // the PFObject being returned from Parse
    // Needs to be deserialized
    var instagramPost: PFObject! {
    
        // sets the outlets with the approprate values
        didSet {
            
            // retrieves the picture file and then loads the image
            if let photo = instagramPost["actualPhoto"] {
                // cast as a PFFile
                self.pictureImageView.file = photo as? PFFile
            } else {
                // Old key used for photo; cast as PFFile
                self.pictureImageView.file = instagramPost["media"] as? PFFile
            }
            // loads the picture; DO NOT FORGET THIS           
            self.pictureImageView.loadInBackground()
            
            // retrieves the caption and displays it
            if let pictureCaption = instagramPost["photoCaption"] {
                self.captionLabel.text = pictureCaption as? String
            } else {
                // Old key used for caption
                self.captionLabel.text = instagramPost["caption"] as? String
            }
            
            // retrieves the date and displays it; Date is stored as a string
            if let date = instagramPost["date"] {
                self.dateLabel.text = date as? String
                // If no date
            } else {
                self.dateLabel.text = "No Date"
            }

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
