//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

class SettingsViewModel {
    fileprivate let userDefaults = UserDefaults()
    
    var hasSetupDefaults: Bool {
        return endTime != nil && startTime != nil
    }
    
    public init() {
        _dailyAmount = userDefaults.integer(forKey: Constants.DailyAmountKey)
        _containerSize = userDefaults.integer(forKey: Constants.ContainerSizeKey)
        _unitOfMeasurement = userDefaults.integer(forKey: Constants.UnitsKey)
        _startTime = userDefaults.object(forKey: Constants.StartTimeKey) as? Date
        _endTime = userDefaults.object(forKey: Constants.EndTimeKey) as? Date
    }
    
    private var _dailyAmount: Int
    var dailyAmount: Int {
        set {
            _dailyAmount = newValue
            userDefaults.set(newValue, forKey: Constants.DailyAmountKey)
        }
        get { return _dailyAmount }
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
            _startTime = newValue
            userDefaults.set(newValue, forKey: Constants.StartTimeKey)
        } get { return _startTime }
    }
    
    private var _endTime: Date?
    var endTime: Date? {
        set {
            _endTime = newValue
            userDefaults.set(newValue, forKey: Constants.EndTimeKey)
        } get { return _endTime }
    }

}
