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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
//        if defaults.bool(forKey: Constants.HasCompletedSetupKey) == false {
            UIApplication.shared.cancelAllLocalNotifications()
            let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
//        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        return true
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        guard let identifier = identifier else {
            return
        }
        
        let notificationCenter = NotificationCenter.default
        switch identifier {
        case Constants.SnoozeNotificationIdentifier:
            notificationCenter.post(name: Notification.Name(rawValue: Constants.SnoozeNotificationIdentifier), object: nil)
        case Constants.StartDayNotificationIdentifier:
            notificationCenter.post(name: Notification.Name(rawValue: Constants.StartDayNotificationIdentifier), object: nil)
        case Constants.FinishedNotificationIdentifier:
            notificationCenter.post(name: Notification.Name(rawValue: Constants.FinishedNotificationIdentifier), object: nil)
        default:
            break
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
}

