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
//AFNetworking
import AFNetworking

//Home Timeline
//import tableViewDelegate and tableViewDataSource
class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlet
    @IBOutlet weak var tableView: UITableView!
    
    //posts to be displayed
    var posts: [PFObject]?
    
    var refreshControl = UIRefreshControl()
    
    
    //viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_ :)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        //Network Call
        networkCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Network Call
        networkCall()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        //Turn on the ProgressHUD and make the networkRequestForMove()
        //        MBProgressHUD.showAdded(to: self.view, animated: true)
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
                
                print(posts)
                
                //reloads data
                self.tableView.reloadData()
                
                self.refreshControl.endRefreshing()
                
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier) as UITableViewHeaderFooterView
//        header.textLabel.text = posts[section]
//        return header
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
//        headerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // headerView.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:0.3)
        
        // set & load avatar image
        var profileView = UIImageView()
        let myImage: UIImage = UIImage(named: "instagram")!
        profileView = UIImageView(image: myImage)
        profileView.frame = CGRect(x: 20, y: 10, width: 30, height: 30)
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15
        profileView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        profileView.layer.borderWidth = 1;
        headerView.addSubview(profileView)
        
        // set & load user name
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 130, y: 25)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        let post = posts?[section]
        
        if let authorName = post?["username"] as? String {
            label.text = authorName
        } else {
            label.text = "Temp"
        }
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
