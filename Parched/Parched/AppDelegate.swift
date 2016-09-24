//
//  AppDelegate.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey(Constants.HasCompletedSetupKey) == false {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        return true
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        guard let identifier = identifier else {
            return
        }
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        switch identifier {
        case Constants.SnoozeNotificationIdentifier:
            notificationCenter.postNotificationName(Constants.SnoozeNotificationIdentifier, object: nil)
        case Constants.StartDayNotificationIdentifier:
            notificationCenter.postNotificationName(Constants.StartDayNotificationIdentifier, object: nil)
        case Constants.FinishedNotificationIdentifier:
            notificationCenter.postNotificationName(Constants.FinishedNotificationIdentifier, object: nil)
        default:
            break
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        completionHandler()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

