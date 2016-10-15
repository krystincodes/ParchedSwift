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
    
    var startTimeString: String {
        if let startTime = defaultsManager.startTime {
            return timeStringFromDate(startTime as Date)
        }
        return ""
    }
    
    var endTimeString: String {
        if let endTime = defaultsManager.endTime {
            return timeStringFromDate(endTime as Date)
        }
        return ""
    }
    
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
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: 0)
        var components = DateComponents()
        components.hour = 7
        defaultsManager.startTime = (calendar as NSCalendar).date(byAdding: components, to: date, options: [])
        components.hour = 20
        defaultsManager.endTime = (calendar as NSCalendar).date(byAdding: components, to: date, options: [])
    }
    
    func setupPickers() {
        startTimePicker = UIDatePicker(frame: CGRect.zero)
        startTimePicker.datePickerMode = .time
        startTimePicker.maximumDate = defaultsManager.endTime as Date?
        endTimePicker = UIDatePicker(frame: CGRect.zero)
        endTimePicker.datePickerMode = .time
        endTimePicker.minimumDate = defaultsManager.startTime as Date?
    }
    
    func showErrorAlert(_ title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveDailyAmountIfValid(_ dailyAmount: String) -> Bool {
        guard let dailyAmount = Int(dailyAmount) , dailyAmount > 0 else {
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
    
    func saveContainerSizeIfValid(_ containerSize: String) -> Bool {
        guard let containerSize = Int(containerSize) , containerSize > 0 else {
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
    
    func saveStartTime(_ time: Date) {
        defaultsManager.startTime = time
    }
    
    func saveEndTime(_ time: Date) {
        defaultsManager.endTime = time
    }
    
    func saveUnitOfMesasurement(_ unit: UnitOfMeasurement?) {
        defaultsManager.unitOfMesaurement = unit
    }
    
    fileprivate func timeStringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter.string(from: date)
    }
}
