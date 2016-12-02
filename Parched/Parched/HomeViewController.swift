//
//  ViewController.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var nextRefillLabel: UILabel!
    @IBOutlet weak var finishedEarlyButton: UIButton!
    @IBOutlet weak var amountDrankTodayLabel: UILabel!
    @IBOutlet weak var unitOfMeasurementSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dailyAmountTextField: UITextField!
    @IBOutlet weak var unitsForDailyAmountLabel: UILabel!
    @IBOutlet weak var containerSizeTextField: UITextField!
    @IBOutlet weak var unitsForContainerSizeLabel: UILabel!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var pushNotificationsSwitch: UISwitch!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var timeLeftContainerView: UIView!
    @IBOutlet weak var finishedEarlyCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var finishedEarlyWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBarContainerView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timePickerBottomConstraint: NSLayoutConstraint!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !viewModel.hasSetupDefaults {
            showSettings()
        } else {
            hideSettings()
        }
        
        timePicker.addTarget(self, action: #selector(timePickerChanged), for: .valueChanged)
        setupNSNotifications()
        updateAllInfo()
//        addRegularViewButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if viewModel.hasSetupDefaults {
        
        //        }
//        scrollView.contentInset = UIEdgeInsetsMake(view.frame.size.height, 0, 0, 0);
    }
    
    @IBAction func dailyAmountValueChanged(_ sender: Any) {
        guard let textField = sender as? UITextField, let text = textField.text else {
            return
        }
        viewModel.dailyAmount = Int(text)!
    }
    
    // MARK: Private functions
    private func addSettingsViewButtons() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideSettings))
    }
    
    private func addRegularViewButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings))
//        (image: UIImage(named: "settings"), style: .plain, target: self, action: )
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCustomAmount))
    }
    
    private func updateAllInfo() {
        populateSettingsFromViewModel()
        updateProgressBarAndLabel()
        resetTimer()
    }
    
//    private func setupPickerViewForSettings() {
//        let doneButtonView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWithPickerTapped()))
//        timePicker.inputView = doneButtonView
//    }
    
    private func populateSettingsFromViewModel() {
        dailyAmountTextField.text = String(viewModel.dailyAmount)
        containerSizeTextField.text = String(viewModel.containerSize)
        startTimeButton.titleLabel?.text = viewModel.startTimeString
        endTimeButton.titleLabel?.text = viewModel.startTimeString
        unitOfMeasurementSegmentedControl.selectedSegmentIndex = viewModel.unitOfMesaurement
    }
    
    @objc private func doneWithPickerTapped() {
        
    }
    
    private func setupNSNotifications() {
        
    }
    
    private func resetTimer() {
        
    }
    
    private func updateProgressBarAndLabel() {
        
    }
    
    // MARK: Actions & Selectors
    
    @objc private func hideSettings() {
        // TODO: Might need some validation/error throwing here
    
        addRegularViewButtons()
        scrollView.contentInset = UIEdgeInsetsMake(view.frame.height, 0, 0, 0);
    }
    
    @objc private func showSettings() {
        populateSettingsFromViewModel()
        addSettingsViewButtons()
        // TODO: Animate
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }

    @objc private func addCustomAmount() {
        
    }
    
    @objc private func timePickerChanged() {
        if startTimePickerIsShowing {
            viewModel.startTime = timePicker.date
            startTimeButton.titleLabel?.text = viewModel.startTimeString
            // TODO Update time for start day notification
        } else if endTimePickerIsShowing {
            viewModel.endTime = timePicker.date
            endTimeButton.titleLabel?.text = viewModel.endTimeString
            // TODO If they changed the end time in the middle of a day, we need to redo our math
        }
    }
    
    @IBAction func finishedEarlyButtonClicked(_ sender: AnyObject) {
        
    }
    
    @IBAction func pushNotifSwitchValueChanged(_ sender: AnyObject) {
        // Open settings OR ask for permission
    }
    
    private var startTimePickerIsShowing = false
    @IBAction func startTimeButtonClicked(_ sender: AnyObject) {
        view.endEditing(true)
        if startTimePickerIsShowing {
            hidePicker()
        } else {
            showPicker()
            if viewModel.startTime == nil {
                viewModel.startTime = timePicker.date
                startTimeButton.titleLabel?.text = viewModel.startTimeString
            }
        }
        endTimePickerIsShowing = !endTimePickerIsShowing
        startTimePickerIsShowing = !startTimePickerIsShowing
    }
    
    private var endTimePickerIsShowing = false
    @IBAction func endTimeButtonClicked(_ sender: AnyObject) {
        view.endEditing(true)
        if endTimePickerIsShowing {
            hidePicker()
        } else {
            showPicker()
            if viewModel.endTime == nil {
                viewModel.endTime = timePicker.date
                endTimeButton.titleLabel?.text = viewModel.endTimeString
            }
        }
        endTimePickerIsShowing = !endTimePickerIsShowing
        startTimePickerIsShowing = !startTimePickerIsShowing
    }
    
    private func hidePicker() {
        view.endEditing(true)
        self.timePickerBottomConstraint.constant = -self.timePicker.frame.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showPicker() {
        view.endEditing(true)
        self.timePickerBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func backgroundTapped(_ sender: Any) {
        if endTimePickerIsShowing || startTimePickerIsShowing {
            hidePicker()
        } else {
            view.endEditing(true)
        }
    }

}

