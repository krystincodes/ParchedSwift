//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static let sharedInstance = UserDefaultsManager()
    fileprivate var userDefaults: UserDefaults!
    
    fileprivate init() {
        userDefaults = UserDefaults.standard
    }
    
    var dailyAmount: Int {
        set {
            userDefaults.set(newValue, forKey: Constants.DailyGoalKey)
        }
        get {
            return userDefaults.integer(forKey: Constants.DailyGoalKey)
        }
    }
    
    var containerSize: Int {
        set {
            userDefaults.set(newValue, forKey: Constants.ContainerSizeKey)
        } get {
            return userDefaults.integer(forKey: Constants.ContainerSizeKey)
        }
    }
    
    var unitOfMesaurement: UnitOfMeasurement? {
        set {
            userDefaults.set(newValue!.hashValue, forKey: Constants.UnitsKey)
        } get {
            return UnitOfMeasurement(rawValue: userDefaults.integer(forKey: Constants.UnitsKey))
        }
    }
    
    var startTime: Date? {
        set {
            userDefaults.set(newValue, forKey: Constants.StartTimeKey)
        } get {
            return userDefaults.object(forKey: Constants.StartTimeKey) as? Date
        }
    }
    
    var endTime: Date? {
        set {
            userDefaults.set(newValue, forKey: Constants.EndTimeKey)
        } get {
            return userDefaults.object(forKey: Constants.EndTimeKey) as? Date
        }
    }
    
    var hasCompletedSetup: Bool {
        set {
            userDefaults.set(newValue, forKey: Constants.HasCompletedSetupKey)
        } get {
            return userDefaults.bool(forKey: Constants.HasCompletedSetupKey)
        }
    }
}

// TODO: Maybe not the best place for this?
enum UnitOfMeasurement: Int {
    case ounces = 0
    case mililiters = 1
}
