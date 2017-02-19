//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var nextRefillLabel: UILabel!
    @IBOutlet weak var finishedEarlyButton: UIButton!
    @IBOutlet weak var amountDrankTodayLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var timeLeftContainerView: UIView!
    @IBOutlet weak var finishedEarlyCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var finishedEarlyWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBarContainerView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarRightConstraint: NSLayoutConstraint!
    
    private var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsViewModel = SettingsViewModel()
        viewModel = MainViewModel(settingsViewModel: settingsViewModel)
        
        setupNSNotifications()
        updateAllInfo()
    }
    
    // MARK: Private functions
    
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
    
    // TODO: Observables
    private func populateSettingsFromViewModel() {
//        dailyAmountTextField.text = String(viewModel.dailyAmount)
//        containerSizeTextField.text = String(viewModel.containerSize)
//        startTimeButton.titleLabel?.text = viewModel.startTimeString
//        endTimeButton.titleLabel?.text = viewModel.startTimeString
//        unitOfMeasurementSegmentedControl.selectedSegmentIndex = viewModel.unitOfMesaurement
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVc = segue.destination as? SettingsViewController {
            settingsVc.viewModel = viewModel.settingsViewModel
        }
    }
    
    @objc private func doneWithPickerTapped() {
        
    }
    
    private func setupNSNotifications() {
        
    }
    
    private func resetTimer() {
        
    }
    
    private func updateProgressBarAndLabel() {
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }

    // MARK: Actions & Selectors

    @IBAction func addCustomAmountTapped(_ sender: Any) {
        
    }
    
    @IBAction func finishedEarlyTapped(_ sender: AnyObject) {
        
    }
}

