//
//  TimelineViewController.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/24/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//


//Fix the subheadings; understand the methods involved
// REMOVE LOGOUT BUTTON: Move to Profile view
// CHANGE THE HEIGHT OF THE SECTION HEADER IF NECESSARY
// Make the header section look
// Change the center of the label in the header
// Make the imageView be responsive depending upon the size of the picture (specifically the height)
// Try using the created_at key to retrieve the date
// Make the date be something like (9 hours ago, or 5 minutes ago)

import UIKit
// Parse
import Parse
// AFNetworking
import AFNetworking


// Home Timeline
// import tableViewDelegate and tableViewDataSource
class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // outlet
    @IBOutlet weak var tableView: UITableView!
    
    // posts to be displayed
    var posts: [PFObject]?
    
    // refreshControl
    var refreshControl = UIRefreshControl()
    
    
    // viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // refreshControl: adds Target and inserts the subview
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_ :)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // Network Call
        networkCall()
    }
    
    
    // viewDidAppear()
    // To refresh the timeline when the user posts an image
    override func viewWillAppear(_ animated: Bool) {
        
        // Network Call
        networkCall()
    }
    
    
    // refreshControlAction: Used whenever refresh is done
    // will make network call
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        // Network Call
        networkCall()
    }
    
    
    // Network Call method
    func networkCall() {
        
        // Makes the query and specifies the class
        let query = PFQuery(className: "Post")
        // orders the posts by createdAt
        query.order(byDescending: "createdAt")
        // limits the query to 20
        query.limit = 20
        
        // send query through built-in Parse method
        // Returns the an array of Posts
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            
            // If posts are not nil
            if let posts = posts {
                
                // sets global posts property
                self.posts = posts
                
                
                // reloads data
                self.tableView.reloadData()
                
                // Ends the refreshing
                self.refreshControl.endRefreshing()
                
            // Error
            } else {
                print("TimelineViewController/networkCall Error: \(error?.localizedDescription)")
            }
        }
    }


    // logout Button Pressed
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        // built-in Parse method
        // Logs users out
        PFUser.logOutInBackground { (error: Error?) in
            
            // if no error
            if error == nil {
                
                // performs segue to loginViewController
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }
    }
    
    
    // cellForRowAt
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // cell property. Cast as InstagramPost.
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramPost", for: indexPath) as! InstagramPost
        
        // Retrieve proper post
        // Make sure that you use indexPath.section. Not indexPath.row. Since we are going by section. Not row within section
        let post = posts?[indexPath.section]
        
        // set post within InstagramPost class
        cell.instagramPost = post
        
        return cell
    }
    
    
    // numberOfRowsInSection
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Only one row per section
        return 1
    }
    
    
    // numberOfSections: number of section headers
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // if posts exist, return the count
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    
    // heightForHeightInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    // viewForHeaderInSection:
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Create the headerView
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        // Change the background color
        headerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        headerView.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:0.3)
        
        // Retrieving image
        let userImage: UIImage = UIImage(named: "instagram")!
        
        // Create the imageView
        let profileImageView = UIImageView(image: userImage)
        // Set the frame (coordinates are top right)
        profileImageView.frame = CGRect(x: 20, y: 10, width: 30, height: 30)
        
        //?????
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15
        profileImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        profileImageView.layer.borderWidth = 1
        
        // Insert into the headerView
        headerView.addSubview(profileImageView)
        
        // Create the label
        let userName = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        // Center of the label
        userName.center = CGPoint(x: 130, y: 25)
        // Color of the label text
        userName.textColor = UIColor.black
        // Center the text
        userName.textAlignment = .center
        
        // ?????
        userName.adjustsFontSizeToFitWidth = true
        
        // Retrieve the correct post to display
        let post = posts?[section]
        
        // Extract the authorName from post and set the label text to the userName
        // If there is no userName, then set it pre-determined String
        if let authorName = post?["userName"] as? String {
            
            userName.text = authorName
            
            // If there is no userName
        } else {
            
            userName.text = "No User"
        }
        
        // Insert the label into the headerView
        headerView.addSubview(userName)
        
        return headerView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
