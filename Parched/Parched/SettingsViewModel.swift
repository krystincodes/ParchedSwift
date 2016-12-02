//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

class SettingsViewModel {
    fileprivate let userDefaults = UserDefaults()
    
    var hasSetupDefaults: Bool {
        return endTime != nil && startTime != nil
    }
    
    var startTimeString: String {
        return startTime?.timeString ?? "Add"
    }
    
    var endTimeString: String {
        return endTime?.timeString ?? "Add"
    }
}

// MARK: Properties (stored in defaults)
extension SettingsViewModel {
    var dailyAmount: Int {
        set {
            userDefaults.set(newValue, forKey: Constants.DailyAmountKey)
        }
        get {
            return userDefaults.integer(forKey: Constants.DailyAmountKey)
        }
    }
    
    var containerSize: Int {
        set {
            userDefaults.set(newValue, forKey: Constants.ContainerSizeKey)
        } get {
            return userDefaults.integer(forKey: Constants.ContainerSizeKey)
        }
    }
    
    var unitOfMesaurement: Int {
        set {
            userDefaults.set(newValue, forKey: Constants.UnitsKey)
        } get {
            return userDefaults.integer(forKey: Constants.UnitsKey)
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
}
