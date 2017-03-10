//
//  InstagramPost.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
//import Parse and ParseUI
import Parse
import ParseUI

//cell for tableView
//Each instagramPost has an imageView and a caption
class InstagramPost: UITableViewCell {

    //outlets
    //pictureImageView is of type PFImageView, not UIImageView
    @IBOutlet weak var pictureImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //the PFObject being returned from Parse
    //Needs to be deserialized
    var instagramPost: PFObject! {
    
        //sets the outlets with the approprate values
        didSet {
            
            //retrieves the picture file and then loads the image
            
            if let photo = instagramPost["actualPhoto"] {
                self.pictureImageView.file = photo as? PFFile
            } else {
                self.pictureImageView.file = instagramPost["media"] as? PFFile
            }

            self.pictureImageView.loadInBackground()
            
            //retrieves the caption and displays it
            
            if let pictureCaption = instagramPost["photoCaption"] {
                self.captionLabel.text = pictureCaption as? String
            } else {
                self.captionLabel.text = instagramPost["caption"] as? String
            }
            
            
            
            if let temp = instagramPost["date"] {
                print(temp)
                self.dateLabel.text = temp as? String
            } else {
                self.dateLabel.text = "Temp"
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
