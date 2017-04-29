//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

class MainViewModel {
    var settings: SettingsViewModel
    
    var hasSetupDefaults: Bool {
        return settings.hasSetupDefaults
    }
    
    var _consumedToday: Int = 0
    var consumedToday: Int {
        get {
            return _consumedToday
        } set {
            _consumedToday = newValue
            settings.userDefaults.set(newValue, forKey: Constants.ConsumedTodayKey)
        }
    }
    
    var percentComplete: Int {
        return _consumedToday / settings.dailyGoal
    }
    
    var refillTimeString: String? {
        guard let timeUntilRefill = timeUntilRefill else { return nil }
        
        let minutes = (timeUntilRefill / 60).truncatingRemainder(dividingBy: 60)
        let hours = (timeUntilRefill / 3600)
        return "\(hours) hours, \(minutes) minutes"
    }
    
    public init(settingsViewModel: SettingsViewModel) {
        self.settings = settingsViewModel
        self.consumedToday = settings.userDefaults.integer(forKey: Constants.ConsumedTodayKey)
    }
    
    public func finishedContainer() {
        let containerSize = settings.containerSize
        consumedToday += containerSize
        updateRefillTimes()
    }
    
    public func updateRefillTimes() {
        guard let startTime = settings.startTime,
            let endTime = settings.endTime,
            let timePerDrink = timeIntervalPerDrink() else { return }
        
        refillTimes = [Date]()
        refillTimes!.append(startTime)
        var start = startTime
        while start < endTime {
            start = start.addingTimeInterval(timePerDrink)
            refillTimes!.append(start)
            print("Adding refill time: \(start)")
        }
    }
    
    // MARK: Private functions
    private var refillTimes: [Date]?
    private var timeUntilRefill: TimeInterval? {
        guard let refillTimes = refillTimes else {
            // TODO: Log
            return nil
        }
        let now = Date()
        if let nextRefillTime = refillTimes.first( where: { $0 > now }) {
            return nextRefillTime.timeIntervalSince(now)
        }
        return nil
    }
    
    private func timeIntervalPerDrink() -> TimeInterval? {
        if let startTime = settings.startTime, let endTime = settings.endTime {
            let timeInDay = endTime.timeIntervalSince(startTime)
            let numberOfBottles = round(Double(settings.dailyGoal - consumedToday / settings.containerSize))
            let timePerBottle = Int(ceil(timeInDay / numberOfBottles))
            return TimeInterval(timePerBottle)
        }
        return nil
    }
}
