//
//  Copyright © 2017 Ryan Stutesman. All rights reserved.
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

final class SettingsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: SettingsViewModel?
    var showingInputForCellType: CellType?
    var shouldShowInputForCellType: CellType?
    var timePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(timePickerChanged), for: .valueChanged)
    }
    
//    fileprivate func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//        alert.addAction(okAction)
//        self.navigationController?.present(alert, animated: true, completion: nil)
//    }

    @objc private func timePickerChanged() {
        guard let date = timePicker?.date else { return }
        if showingInputForCellType == .startTime {
            viewModel?.startTime = date
        } else {
            viewModel?.setEndTime(date) { (errorString) in
                if let error = errorString {
                    self.showErrorAlert("Oops", message: error)
                }
            }
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
    }

    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.resignFirstResponder()
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
            
            // TODO: Get next button working properly
            cell.textField.inputAccessoryView = getToolbarForInputCell(cellType)
            if cellType == .startTime || cellType == .endTime {
                cell.textField.inputView = timePicker
            } else {
                cell.textField.keyboardType = .numberPad
            }
            
            if shouldShowInputForCellType == cellType {
                cell.textField.becomeFirstResponder()
            }
            
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
    
    func getToolbarForInputCell(_ type: CellType) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if type == .endTime {
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWithPickerTapped))
            toolbar.items = [flexSpace, doneButton]
            return toolbar
        }
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        toolbar.items = [flexSpace, nextButton]
        return toolbar
    }

    @objc private func doneWithPickerTapped() {
        guard let type = showingInputForCellType, type == .endTime else { return }
        
        shouldShowInputForCellType = nil
        view.endEditing(true)
        let indexPath = IndexPath(row: type.rawValue, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc private func nextTapped() {
        guard let row = showingInputForCellType?.rawValue else { return }
        
        print("showingInputForCellType: \(String(describing: showingInputForCellType))")
        let nextRow = row + 1
        shouldShowInputForCellType = CellType(rawValue: nextRow)
        let currentIndex = IndexPath(row: row, section: 0)
        let nextIndex = IndexPath(row: nextRow, section: 0)
        tableView.reloadRows(at: [currentIndex, nextIndex], with: .automatic)
    }
}

// MARK: UITableViewCellDelegates
extension SettingsViewController: TextFieldCellDelegate, UnitsCellDelegate, SwitchCellDelegate {
    internal func didBeginEditing(type: CellType) {
        showingInputForCellType = type
        if let startTime = viewModel?.startTime, let endTime = viewModel?.endTime {
            timePicker?.date = (type == .startTime) ? startTime : endTime
        }
    }

    internal func valueChanged(amount: Int, type: CellType) {
        if type == .containerSize {
            viewModel?.setContainerSize(amount) { (errorString) in
                if let errorString = errorString {
                    self.showErrorAlert("Oops", message: errorString)
                }
            }
        } else if type == .dailyGoal {
            viewModel?.setDailyGoal(amount) { (errorString) in
                if let errorString = errorString {
                    self.showErrorAlert("Oops", message: errorString)
                }
            }
        }
    }

    internal func unitsChanged(value: Int) {
        viewModel?.unitOfMesaurement = value
        let containerSizeIndex = IndexPath(row: CellType.containerSize.rawValue, section: 0)
        let dailyGoalIndex = IndexPath(row: CellType.dailyGoal.rawValue, section: 0)
        tableView.reloadRows(at: [containerSizeIndex, dailyGoalIndex], with: .automatic)
    }
    
    func switchValueChanged(value: Bool) {
        // TODO: Disable or ask for push notifications
        
    }
}
