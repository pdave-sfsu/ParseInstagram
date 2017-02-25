//
//  AppDelegate.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/23/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
//import Parse
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //window
    var window: UIWindow?

    //first method run when app opens
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Connects to the Parse account
        //Has proper id's
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "tempcodpath2"
                configuration.clientKey = "thismaybeatest"
                configuration.server = "http://tempcodpath2.herokuapp.com/parse"
            })
        )
        
        //if current user is present
        //Uses Parse built-in method PFUser.current()
        if PFUser.current() != nil {
            
            print("There is a current user.")
            
            //reference the storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            //Get the InstagramNavigationController using storyboard ID
            let vc = storyboard.instantiateViewController(withIdentifier: "InstagramNavigationController")
            
            //rootViewController determines the starting viewController
            //Set the starting viewController to be timelineViewController
            window?.rootViewController = vc
            
            
            //reference the timeline Navigation Controller by using the Storyboard ID
            //Cast it as UINavigationController
            let timelineNavigationController = storyboard.instantiateViewController(withIdentifier: "InstagramNavigationController") as! UINavigationController
            
            //Change the tab Bar title
            timelineNavigationController.tabBarItem.title = "Timeline"
            
            //Adds the image onto the tab bar; 242px
            //        timelineNavigationController.tabBarItem.image = UIImage(named: "nowPlaying24")
            
            
            //reference the addPhoto Navigation Controller by using the Storyboard ID
            //Cast it as UINavigationController
            let addPhotoNavigationController = storyboard.instantiateViewController(withIdentifier: "addPhotoNavigationController") as! UINavigationController
            
            //Change the tab Bar title
            addPhotoNavigationController.tabBarItem.title = "Add Photo"
            
            //Adds the image on the tab bar; 24px
            //        addPhotoViewController.tabBarItem.image = UIImage(named: "topRated24")
            
            
            //Creating the TAB BAR
            
            //Initialized the tabBarController
            let tabBarController = UITabBarController()
            
            //Added the two navigation controllers to the tab bar
            tabBarController.viewControllers = [timelineNavigationController, addPhotoNavigationController]
            
//            var navigationBarAppearace = UINavigationBar.appearance()
//            
//            navigationBarAppearace.tintColor = UIColor.black
//            navigationBarAppearace.barTintColor = UIColor.orange
//            
//            // change navigation item title color
//            navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
            
            
            //initialize window
            window = UIWindow(frame: UIScreen.main.bounds)
            
            //rootViewController sets the initial view controller
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

