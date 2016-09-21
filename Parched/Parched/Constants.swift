//
//  Constants.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

struct Constants {
    static let UnitsKey = "Units"
    static let StartTimeKey = "StartTime"
    static let EndTimeKey = "EndTime"
    static let DailyAmountKey = "DailyAmount"
    static let ContainerSizeKey = "ContainerSize"
    static let StartedDayKey = "StartedDay"
    static let DrankTodayKey = "DrankToday"
    
    static let SnoozeActionIdentifier = "SnoozeAction"
    static let StartActionIdentifier = "StartAction"
    static let FinishedActionIdentifier = "FinishAction"
    
    static let StartCategoryIdentifier = "StartDayCategory"
    static let NextRefillCategoryIdentifier = "NextRefillCategory"
    static let EndCategoryIdentifier = "EndDayCategory"
    
    static let SnoozeNotificationIdentifier = "SnoozeNotification"
    static let StartDayNotificationIdentifier = "StartDayNotification"
    static let FinishedNotificationIdentifier = "FinishedNotification"
    
    static let AppGroupName = "group.com.krystinstutesman.ParchedTodayExtensionSharingDefaults"
    static let TimerKey = "TimerKey"
    
    static let PushNotificationAskKey = "HasAskedNotifications"
    static let HasCompletedSetupKey = "CompletedSetup"
    static let DailyNotificationKey = "DailyNotificationKey"
    static let DailyNotificationValue = "DailyNotificationValue"
}