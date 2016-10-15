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
        startTimeTextField.text = startTimeString
        endTimeTextField.text = endTimeString
        
        unitOfMeasurementSegmentedControl.selectedSegmentIndex = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descriptionLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.descriptionLabel.alpha = 1;
        }) 
    }
    
    override var prefersStatusBarHidden : Bool {
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
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) 
    }
    
    // MARK - Keyboard
    func keyboardWillShow(_ notification: Notification) {
        if let info = (notification as NSNotification).userInfo, let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
//            let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
            let keyboardEndY = (info[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.origin.y
            let proceedButtonBottom = proceedButton.frame.origin.y + proceedButton.frame.size.height;
            if keyboardEndY > proceedButtonBottom {
                return
            } else {
                let needMoveUp = proceedButtonBottom - keyboardEndY + 10
                amountMovedForKeyboard = needMoveUp
//                view.layoutIfNeeded()
                titleViewTopConstraint.constant -= needMoveUp
                UIView.animate(withDuration: duration, animations: {
                    self.titleView.alpha = 0
                    self.view.layoutIfNeeded()
                }) 
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        guard amountMovedForKeyboard != 0  else {
            return
        }
        
        if let info = (notification as NSNotification).userInfo, let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
            titleViewTopConstraint.constant += amountMovedForKeyboard
            amountMovedForKeyboard = 0
            UIView.animate(withDuration: duration, animations: {
                self.titleView.alpha = 1
                self.view.layoutIfNeeded()
            }) 
        }
    }
    
    // MARK - Actions
    @IBAction func unitsSegmentedControlValueChanged(_ sender: AnyObject) {
        let control = sender as! UISegmentedControl
        saveUnitOfMesasurement(UnitOfMeasurement(rawValue: control.selectedSegmentIndex))
    }
    
    @IBAction func proceedButtonClicked(_ sender: AnyObject) {
        switch currentSection {
        case 0:
            moveLabelsForward()
            break
        case 1:
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
            self.present(vc!, animated: true, completion: { () -> Void in
                self.defaultsManager.hasCompletedSetup = true
            })
        default:
            break
        }
    }
    
    @IBAction func backgroundTapped(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
}
