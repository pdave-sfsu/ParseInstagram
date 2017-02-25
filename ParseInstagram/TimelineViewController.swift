//
//  TimelineViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        
        networkCall();


        // Do any additional setup after loading the view.
    }
    
    func networkCall() {
//        var query = PFQuery(className: "Post")
//        
//        query.getObjectInBackground(withId: "imkmJsHVIH") { (post: PFObject?, error: Error?) in
//            if error == nil {
//                print(post)
//            } else {
//                print(error)
//            }
//        }
        
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the data fetched
                print(posts)
                
                self.posts = posts
                
            } else {
                // handle error
            }
        }
        tableView.reloadData()

        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        print("logout button pressed")
        
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil {
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }

        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
        
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramPost", for: indexPath) as! InstagramPost
        
        let post = posts?[indexPath.row]
        
        let image = post?["media"] as? UIImage
        let caption = post?["caption"] as? String
        
        cell.pictureImageView.image = image
        
        cell.captionLabel.text = caption
        
        return cell
        
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
