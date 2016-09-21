//
//  BaseViewController.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let defaultsManager = UserDefaultsManager.sharedInstance
    var startTimePicker: UIDatePicker!
    var endTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserDefaultsIfNeeded()
        setupPickers()
    }
    
    func setUserDefaultsIfNeeded() {
        // This is really only for the very first time the app opens
        // Every other time these values will be in the defaults
        // TODO - Might be a better way
        guard defaultsManager.endTime != nil && defaultsManager.startTime != nil
            && defaultsManager.unitOfMesaurement != nil else {
            return
        }
        
        defaultsManager.unitOfMesaurement = .ounces
        // All we are concerned about is the time of day, not date
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate(timeIntervalSince1970: 0)
        let components = NSDateComponents()
        components.hour = 7
        defaultsManager.startTime = calendar.dateByAddingComponents(components, toDate: date, options: [])
        components.hour = 20
        defaultsManager.endTime = calendar.dateByAddingComponents(components, toDate: date, options: [])
    }
    
    func setupPickers() {
        startTimePicker = UIDatePicker(frame: CGRectZero)
        startTimePicker.datePickerMode = .Time
        startTimePicker.maximumDate = defaultsManager.endTime
        endTimePicker = UIDatePicker(frame: CGRectZero)
        endTimePicker.datePickerMode = .Time
        endTimePicker.minimumDate = defaultsManager.startTime
    }
    
    func showErrorAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveDailyAmountIfValid(dailyAmount: String) -> Bool {
        guard let dailyAmount = Int(dailyAmount) where dailyAmount > 0 else {
            showErrorAlert("Oops", message: "Your daily amount cannot be 0... That's unhealthy.")
            return false
        }
        guard let unitOfMeasurement = defaultsManager.unitOfMesaurement else {
            print("Unit of measurement nil when saving daily amount size")
            return false
        }
        
        if unitOfMeasurement == .ounces && dailyAmount < 400 ||
            unitOfMeasurement == .mililiters && dailyAmount < 12000 {
            defaultsManager.dailyAmount = dailyAmount
            return true
        } else {
            showErrorAlert("Oops", message: "Your daily amount is too high. I'm afraid you'd drown.")
            return false
        }
    }
    
    func saveContainerSizeIfValid(containerSize: String) -> Bool {
        guard let containerSize = Int(containerSize) where containerSize > 0 else {
            showErrorAlert("", message: "Container size can't be 0. If you're drinking air, there's probably another app for that.")
            return false
        }

        let dailyAmount = defaultsManager.dailyAmount
        if dailyAmount > containerSize {
            defaultsManager.containerSize = containerSize
            return true
        } else {
            showErrorAlert("Oops", message: "Your container is larger than your daily amount. If I tried to do that math I'd crash. Try again.")
            return false
        }
    }
    
    func saveStartTime(time: NSDate) {
        defaultsManager.startTime = time
    }
    
    func saveEndTime(time: NSDate) {
        defaultsManager.endTime = time
    }
    
    func saveUnitOfMesasurement(unit: UnitOfMeasurement?) {
        defaultsManager.unitOfMesaurement = unit
    }
}