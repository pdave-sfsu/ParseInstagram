//
//  InstagramPost.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramPost: UITableViewCell {

    
    @IBOutlet weak var pictureImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            
            print("This was run")
            
            self.pictureImageView.file = instagramPost["media"] as? PFFile
            self.pictureImageView.loadInBackground()
            
            self.captionLabel.text = instagramPost["caption"] as? String
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
