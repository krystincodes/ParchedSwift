//
//  Copyright © 2016 Ryan Stutesman. All rights reserved.
//

import UIKit

class SettingsViewModel {
    let userDefaults = UserDefaults()
    
    var startTimePeriod: String? {
        return startTime?.periodString
    }
    
    var endTimePeriod: String? {
        return endTime?.periodString
    }
    
    var startTimeString: String? {
        return startTime?.timeString
    }
    
    var endTimeString: String? {
        return endTime?.timeString
    }
    
    var unitOfMesaurementString: String? {
        if unitOfMesaurement == 1 {
            return "ml"
        }
        return "oz"
    }
    
    var hasSetupDefaults: Bool {
        return endTime != nil && startTime != nil
    }
    
    public init() {
        dailyGoal = userDefaults.integer(forKey: Constants.DailyGoalKey)
        containerSize = userDefaults.integer(forKey: Constants.ContainerSizeKey)
        _unitOfMeasurement = userDefaults.integer(forKey: Constants.UnitsKey)
        _startTime = userDefaults.object(forKey: Constants.StartTimeKey) as? Date
        endTime = userDefaults.object(forKey: Constants.EndTimeKey) as? Date
    }
    
    // MARK: - Setter methods
    
    func setDailyGoal(_ goal: Int, completion: @escaping(_ errorText: String?) -> Void) {
        let maxValue = Bool(_unitOfMeasurement as NSNumber) ? 250 : 2500
        if goal > maxValue {
            completion("That is far too high of a daily goal. Please try again.")
        } else if goal == 0 {
            completion("Daily amount cannot be zero.")
        } else {
            dailyGoal = goal
            userDefaults.set(goal, forKey: Constants.DailyGoalKey)
            completion(nil)
        }
    }
    
    func setContainerSize(_ size: Int, completion: @escaping(_ errorText: String?) -> Void) {
        if size == 0 {
            completion("Container size can't be 0. If you're drinking air, there's probably another app for that.")
        } else if size > dailyGoal {
            completion("Your container is larger than your daily goal. Please try again.")
        } else {
            containerSize = size
            userDefaults.set(size, forKey: Constants.ContainerSizeKey)
            completion(nil)
        }
    }
    
    func setEndTime(_ time: Date, completion: @escaping(_ errorText: String?) -> Void) {
        if let startTime = _startTime, startTime > time {
            completion("End time cannot be before start time. Please try again.")
        } else {
            endTime = time
            userDefaults.set(time, forKey: Constants.EndTimeKey)
            completion(nil)
        }
        // TODO: If they changed the end time in the middle of a day, we need to redo our math
        // Notification for it probably
    }
    
    internal (set) var dailyGoal: Int
    internal (set) var containerSize: Int
    
    private var _unitOfMeasurement: Int
    var unitOfMesaurement: Int {
        set {
            _unitOfMeasurement = newValue
            userDefaults.set(newValue, forKey: Constants.UnitsKey)
        } get { return _unitOfMeasurement }
    }
    
    private var _startTime: Date?
    var startTime: Date? {
        set {
            if let endTime = endTime, let startTime = newValue, endTime < startTime {
                 self.endTime = Date(timeInterval: 3600 * 8, since: startTime)
            }
            // TODO: Update time for start day notification

            _startTime = newValue
            userDefaults.set(newValue, forKey: Constants.StartTimeKey)
        } get { return _startTime }
    }
    internal (set) var endTime: Date?

    var hasEnabledPushes: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
}
