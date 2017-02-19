//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class SettingsViewModel {
    fileprivate let userDefaults = UserDefaults()
    
    var startTimePeriod: String? {
        return startTime?.periodString
    }
    
    var endTimePeriod: String? {
        return endTime?.periodString
    }

    var unitOfMesaurementString: String? {
        if unitOfMesaurement == 1 {
            return "ml"
        }
        return "oz"
    }
    
    var startTimeString: String? {
        return startTime?.timeString
    }
    
    var endTimeString: String? {
        return endTime?.timeString
    }
    
    var hasSetupDefaults: Bool {
        return endTime != nil && startTime != nil
    }
    
    public init() {
        _dailyGoal = userDefaults.integer(forKey: Constants.DailyGoalKey)
        _containerSize = userDefaults.integer(forKey: Constants.ContainerSizeKey)
        _unitOfMeasurement = userDefaults.integer(forKey: Constants.UnitsKey)
        _startTime = userDefaults.object(forKey: Constants.StartTimeKey) as? Date
        _endTime = userDefaults.object(forKey: Constants.EndTimeKey) as? Date
    }
    
    private var _dailyGoal: Int
    var dailyGoal: Int {
        set {
            _dailyGoal = newValue
            userDefaults.set(newValue, forKey: Constants.DailyGoalKey)
        }
        get { return _dailyGoal }
    }

    private var _containerSize: Int
    var containerSize: Int {
        set {
            
            _containerSize = newValue
            userDefaults.set(newValue, forKey: Constants.ContainerSizeKey)
        } get { return _containerSize }
    }
    
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
            if let endTime = _endTime, let startTime = newValue, endTime < startTime {
                self.endTime = Date(timeInterval: 3600 * 8, since: startTime)
            }
            _startTime = newValue
            userDefaults.set(newValue, forKey: Constants.StartTimeKey)
        } get { return _startTime }
    }
    
    private var _endTime: Date?
    var endTime: Date? {
        set {
            guard let startTime = _startTime, let endTime = newValue, startTime < endTime else {
                // TODO: showAlert(title: "Whoops", message: "End time cannot be before start time. Please try again.")
                return
            }
            _endTime = newValue
            userDefaults.set(newValue, forKey: Constants.EndTimeKey)
        } get { return _endTime }
    }

    var hasEnabledPushes: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
}
