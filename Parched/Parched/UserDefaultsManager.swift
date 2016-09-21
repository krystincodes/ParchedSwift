//
//  UserDefaultsManager.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static let sharedInstance = UserDefaultsManager()
    private var userDefaults: NSUserDefaults!
    
    private init() {
        userDefaults = NSUserDefaults.standardUserDefaults()
    }
    
    var dailyAmount: Int {
        set {
            userDefaults.setInteger(newValue, forKey: Constants.DailyAmountKey)
        }
        get {
            return userDefaults.integerForKey(Constants.DailyAmountKey)
        }
    }
    
    var containerSize: Int {
        set {
            userDefaults.setInteger(newValue, forKey: Constants.ContainerSizeKey)
        } get {
            return userDefaults.integerForKey(Constants.ContainerSizeKey)
        }
    }
    
    var unitOfMesaurement: UnitOfMeasurement? {
        set {
            userDefaults.setInteger(newValue!.hashValue, forKey: Constants.UnitsKey)
        } get {
            return UnitOfMeasurement(rawValue: userDefaults.integerForKey(Constants.UnitsKey))
        }
    }
    
    var startTime: NSDate? {
        set {
            userDefaults.setObject(newValue, forKey: Constants.StartTimeKey)
        } get {
            return userDefaults.objectForKey(Constants.StartTimeKey) as? NSDate
        }
    }
    
    var endTime: NSDate? {
        set {
            userDefaults.setObject(newValue, forKey: Constants.EndTimeKey)
        } get {
            return userDefaults.objectForKey(Constants.EndTimeKey) as? NSDate
        }
    }
    
    var hasCompletedSetup: Bool {
        set {
            userDefaults.setBool(newValue, forKey: Constants.HasCompletedSetupKey)
        } get {
            return userDefaults.boolForKey(Constants.HasCompletedSetupKey)
        }
    }
}

// TODO: Maybe not the best place for this?
enum UnitOfMeasurement: Int {
    case ounces = 0
    case mililiters = 1
}