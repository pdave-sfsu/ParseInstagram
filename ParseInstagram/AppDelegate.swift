//
//  AppDelegate.swift
//  ParseInstagram
//
//  Created by Poojan Dave on 2/23/17.
//  Copyright © 2017 Poojan Dave. All rights reserved.
//

import UIKit
// import Parse
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // window
    var window: UIWindow?

    
    // first method run when app opens
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Connects to the Parse account
        // Has proper id's
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "tempcodpath2"
                configuration.clientKey = "thismaybeatest"
                configuration.server = "http://tempcodpath2.herokuapp.com/parse"
            })
        )
        
        
        // reference the storyboard
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // reference of loginViewController using the Storyboard ID
        let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        // reference to tabBar using the Storyboard ID
        let tabBar = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController")
        
        
        // initialize window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // if current user is present, then go to tab bar controller
        // Else, go to loginViewController
        // Uses Parse built-in method PFUser.current() to retrieve the current user
        if PFUser.current() != nil {
            
            print("There is a current user.")
            
            // rootViewController sets the initial view controller
            // tabBar will be the first viewController
            window?.rootViewController = tabBar
            
        } else {
            
            // loginViewController will be first viewController
            window?.rootViewController = loginViewController
        }
        
        // ??????
        window?.makeKeyAndVisible()
        
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

