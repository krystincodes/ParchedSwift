//
//  WalkthroughViewController.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class WalkthroughViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dailyAmountTextField: UITextField!
    @IBOutlet weak var unitOfMeasurementSegmentedControl: UISegmentedControl!
    @IBOutlet weak var containerSizeTextField: UITextField!
    @IBOutlet weak var containerUnitsLabel: UILabel!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var descriptionLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIView!
    
    var currentSection = 0
    var amountMovedForKeyboard: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        startTimeTextField.inputView = startTimePicker
        endTimeTextField.inputView = endTimePicker
        unitOfMeasurementSegmentedControl.selectedSegmentIndex = 0
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.descriptionLabel.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3) {
            self.descriptionLabel.alpha = 1;
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func moveLabelsForward() {
        currentSection += 1
        if currentSection == 3 {
            proceedButton.titleLabel?.text = "Done"
        } else {
             proceedButton.titleLabel?.text = "Next"
        }
        descriptionLabelLeadingConstraint.constant -= descriptionLabel.frame.size.width + 40
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK - Keyboard
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo, keyboardEndY = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().origin.y,
           duration = info[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
            let proceedButtonBottom = proceedButton.frame.origin.y + proceedButton.frame.size.height;
            if keyboardEndY > proceedButtonBottom {
                return
            } else {
                let needMoveUp = proceedButtonBottom - keyboardEndY + 10
                amountMovedForKeyboard = needMoveUp
//                view.layoutIfNeeded()
                titleViewTopConstraint.constant -= needMoveUp
                UIView.animateWithDuration(duration) {
                    self.titleView.alpha = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard amountMovedForKeyboard != 0  else {
            return
        }
        
        if let info = notification.userInfo, duration = info[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
            titleViewTopConstraint.constant += amountMovedForKeyboard
            amountMovedForKeyboard = 0
            UIView.animateWithDuration(duration) {
                self.titleView.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK - Actions
    @IBAction func unitsSegmentedControlValueChanged(sender: AnyObject) {
        let control = sender as! UISegmentedControl
        saveUnitOfMesasurement(UnitOfMeasurement(rawValue: control.selectedSegmentIndex))
    }
    
    @IBAction func proceedButtonClicked(sender: AnyObject) {
        switch currentSection {
        case 0:
            moveLabelsForward()
            break
        case 1:
            // TODO: This will probably break if empty? Idk might return empty string which would be fine
            if saveDailyAmountIfValid(dailyAmountTextField.text!) {
                moveLabelsForward()
            }
            break
        case 2:
            if saveContainerSizeIfValid(containerSizeTextField.text!) {
                moveLabelsForward()
            }
            break
        case 3:
            saveStartTime(startTimePicker.date)
            saveEndTime(endTimePicker.date)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.presentViewController(vc!, animated: true, completion: { () -> Void in
                self.defaultsManager.hasCompletedSetup = true
            })
        default:
            break
        }
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
}
