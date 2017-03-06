//
//  TimelineViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
//Parse
import Parse

//Home Timeline
//import tableViewDelegate and tableViewDataSource
class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlet
    @IBOutlet weak var tableView: UITableView!
    
    //posts to be displayed
    var posts: [PFObject]?
    
    
    //viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        //Network Call
        networkCall()
    }
    
    
    //Network Call method
    func networkCall() {
        
        //Makes the query and specifies the class
        //orders the posts by createdAt
        //limits the query to 20
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.limit = 20
        
        //send query through built-in Parse method
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            
            //If posts are not nil
            if let posts = posts {
                
                //sets global posts property
                self.posts = posts
                
                //reloads data
                self.tableView.reloadData()
                
            //Error
            } else {
                print("TimelineViewController/networkCall Error: \(error?.localizedDescription)")
            }
        }
    }


    //logout Button Pressed
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        //built-in Parse method
        PFUser.logOutInBackground { (error: Error?) in
            
            //if no error
            if error == nil {
                
                //performs segue to loginViewController
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }
    }
    
    
    //numberOfRowsInSection
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if posts exist, return the count
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    
    //cellForRowAt
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell property. Cast as InstagramPost.
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramPost", for: indexPath) as! InstagramPost
        
        //Retrieve proper post
        let post = posts?[indexPath.row]
        
        //set post within InstagramPost class
        cell.instagramPost = post
        
        return cell
        
    }
    
    
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
