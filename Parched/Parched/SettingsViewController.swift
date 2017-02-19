//
//  Copyright © 2017 Krystin Stutesman. All rights reserved.
//

import UIKit

// MARK: Delegates for tableViewCells
protocol TextFieldCellDelegate: class {
    func didBeginEditing(type: CellType)
    func valueChanged(amount: Int, type: CellType)
}

protocol TimeCellDelegate: class {
    func timeButtonTapped(type: CellType)
}

protocol UnitsCellDelegate: class {
    func unitsChanged(value: Int)
}

protocol SwitchCellDelegate: class {
    func switchValueChanged(value: Bool)
}

final class SettingsViewController: UIViewController {
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timePickeHiddenBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var timePickerShowingBottomConstraint: NSLayoutConstraint!

    var viewModel: SettingsViewModel?
    var showingInputForCellType: CellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toolbarDoneButtonTapped(_ sender: Any) {
        // reload cell for start or end time
        
    }
    
    @objc private func timePickerChanged() {
        if showingInputForCellType == .startTime {
            viewModel?.startTime = timePicker.date
            // TODO: Update time for start day notification
        } else {
            viewModel?.startTime = timePicker.date
            // TODO: If they changed the end time in the middle of a day, we need to redo our math
        }
    }
}

// MARK: UITableViewDelegate & DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = CellType(rawValue: indexPath.row), let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        
        switch cellType {
        case .containerSize, .dailyGoal, .startTime, .endTime:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell") as! TextFieldTableViewCell
            cell.initWith(type: cellType, viewModel: viewModel)
            cell.delegate = self
            return cell
        case .units:
            let cell = tableView.dequeueReusableCell(withIdentifier: "unitsCell") as! UnitsTableViewCell
            cell.initWith(type: cellType, viewModel: viewModel)
            cell.delegate = self
            return cell
        case .pushSettings:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.initWith(type: cellType, viewModel: viewModel)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: UITableViewCellDelegates
extension SettingsViewController: TextFieldCellDelegate, UnitsCellDelegate, SwitchCellDelegate {
    
    internal func didBeginEditing(type: CellType) {
        showingInputForCellType = type
        if type == .startTime || type == .endTime {
            timePickerShowingBottomConstraint.isActive = true
            timePickerShowingBottomConstraint.isActive = false
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    internal func valueChanged(amount: Int, type: CellType) {
        showingInputForCellType = nil
        if type == .containerSize {
            viewModel?.containerSize = amount
        } else if type == .dailyGoal {
            viewModel?.dailyGoal = amount
        }
    }

    internal func unitsChanged(value: Int) {
        viewModel?.unitOfMesaurement = value
    }
    
    func switchValueChanged(value: Bool) {
        // TODO: Disable or ask for push notifications
    }
}
