//
//  Copyright © 2017 Ryan Stutesman. All rights reserved.
//

import UIKit

enum CellType: Int {
    case containerSize, dailyGoal, startTime, endTime, units, pushSettings
}

extension CellType {
    func titleString() -> String {
        switch self {
        case .containerSize:
            return "Container Size"
        case .dailyGoal:
            return "Daily Goal"
        case .startTime:
            return "Start Time"
        case .endTime:
            return "End Time"
        case .units:
            return "Unit of Measurement"
        case .pushSettings:
            return "Push Notifications"
        }
    }
}

class BaseSettingsCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    var type: CellType? {
        didSet {
            label.text = type?.titleString()
        }
    }
    
    func initWith(type: CellType, viewModel: SettingsViewModel) {
        // REQUIRED OVERRIDE
    }
}

final class TextFieldTableViewCell: BaseSettingsCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var unitsLabel: UILabel!
    
    var delegate: TextFieldCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let type = type else { return }
        delegate?.didBeginEditing(type: type)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type = type,
            let text = textField.text else {
            return
        }
        
        if type == .containerSize || type == .dailyGoal {
            guard let amount = Int(text) else {
                return
            }
            delegate?.valueChanged(amount: amount, type: type)
        }
    }
    
    override func initWith(type: CellType, viewModel: SettingsViewModel) {
        self.type = type
        switch type {
        case .containerSize:
            textField.text = String(viewModel.containerSize)
            unitsLabel.text = viewModel.unitOfMesaurementString
        case .dailyGoal:
            textField.text = String(viewModel.dailyGoal)
            unitsLabel.text = viewModel.unitOfMesaurementString
        case .startTime:
            textField.text = viewModel.startTimeString
            unitsLabel.text = viewModel.startTimePeriod
        case .endTime:
            textField.text = viewModel.endTimeString
            unitsLabel.text = viewModel.endTimePeriod
        default:
            break
        }
    }
}

final class UnitsTableViewCell: BaseSettingsCell {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        delegate?.unitsChanged(value: segmentedControl.selectedSegmentIndex)
    }
    
    var delegate: UnitsCellDelegate?
    
    override func initWith(type: CellType, viewModel: SettingsViewModel) {
        segmentedControl.selectedSegmentIndex = viewModel.unitOfMesaurement
    }
}

final class SwitchTableViewCell: BaseSettingsCell {
    
    @IBOutlet weak var pushNotificationsSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchValueChanged(value: pushNotificationsSwitch.isOn)
    }
    
    var delegate: SwitchCellDelegate?
    
    override func initWith(type: CellType, viewModel: SettingsViewModel) {
        pushNotificationsSwitch.isOn = viewModel.hasEnabledPushes
    }
}
