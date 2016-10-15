//
//  ViewController.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(showSettings))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCustomAmout))

        
        readInfoFromDefaults()
        setupNSNotifications()
        updateProgressBarAndLabel()
        resetTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    - (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self checkNotificationsEnabled];
//    
//    self.timeLeftLabel.text = [self timeFormatted:self.timeForCurrentBottle];
//    self.scrollView.contentInset = UIEdgeInsetsMake(self.view.frame.size.height, 0, 0, 0);
//    self.scrollView.contentOffset = CGPointMake(0, -self.view.frame.size.height);
//    
//    if (![self hasSeenWalkthrough]) {
//    [self createCoverView];
//    } else {
//    [self setupDailyNotification];
//    }
//    }
    
    
    // Timer logic
    func readInfoFromDefaults() {
        
    }
    
    func setupNSNotifications() {
        
    }
    
    func resetTimer() {
        
    }
    
    func updateProgressBarAndLabel() {
        
    }
    
    // Actions
    
    func showSettings() {
        
    }

    func addCustomAmout() {
        
    }
    
    @IBAction func finishedEarlyButtonClicked(_ sender: AnyObject) {
        
    }
    
    @IBAction func pushNotifSwitchValueChanged(_ sender: AnyObject) {
        
    }
    
    @IBAction func startTimeButtonClicked(_ sender: AnyObject) {
        
    }
    
    @IBAction func endTimeButtonClicked(_ sender: AnyObject) {
        
    }
    
}

