//
//  Copyright © 2016 Ryan Stutesman. All rights reserved.
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProgressBarAndLabel()
        updateCountdown()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVc = segue.destination as? SettingsViewController {
            settingsVc.viewModel = viewModel.settings
        }
    }
    
    // MARK: Private functions

    private func setupThemeColors() {
        view.backgroundColor = Theme.primaryColor
        timeLeftLabel.textColor = Theme.textColor
        nextRefillLabel.textColor = Theme.textColor
        amountDrankTodayLabel.textColor = Theme.textColor

        finishedEarlyButton.tintColor = Theme.textColor
        finishedEarlyButton.backgroundColor = Theme.secondaryColor
        progressBarView.backgroundColor = Theme.secondaryColor
        navigationItem.leftBarButtonItem?.tintColor = Theme.secondaryColor
        navigationItem.rightBarButtonItem?.tintColor = Theme.secondaryColor
    }
    
    private func updateCountdown() {
        timeLeftLabel.text = viewModel.refillTimeString
        Timer.init(fire: Date(), interval: 60, repeats: true, block: { (timer) in
            self.timeLeftLabel.text = self.viewModel.refillTimeString
        }).fire()
    }
    
    private func updateProgressBarAndLabel() {
        let goal = viewModel.settings.dailyGoal
        let consumed = viewModel.consumedToday
        amountDrankTodayLabel.text = "\(consumed) / \(goal) \(String(describing: viewModel.settings.unitOfMesaurementString))"
        
        let percentage = consumed / goal
        let parentWidth = progressBarContainerView.frame.width
        let constraintWidth = parentWidth - parentWidth * CGFloat(percentage)
        progressBarRightConstraint.constant = constraintWidth
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
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
        viewModel.finishedContainer()
        updateCountdown()
    }
}

