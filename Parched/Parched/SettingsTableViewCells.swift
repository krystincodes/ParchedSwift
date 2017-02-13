//
//  Copyright © 2017 Krystin Stutesman. All rights reserved.
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

final class AmountTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var unitsLabel: UILabel!
    
    var delegate: AmountCellDelegate?
    var type: CellType? {
        didSet {
            label.text = type?.titleString()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type = type,
            let text = textField.text,
            let amount = Int(text) else {
            return
        }
        
        delegate?.amountUpdated(amount: amount, type: type)
    }
}

final class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    
    @IBAction func timeButtonTapped(_ sender: Any) {
        guard let type = type else { return }
        delegate?.timeButtonTapped(type: type)
    }
    
    var delegate: TimeCellDelegate?
    var type: CellType? {
        didSet {
            label.text = type?.titleString()
        }
    }
}

final class UnitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        delegate?.unitsChanged(value: segmentedControl.selectedSegmentIndex)
    }
    
    var delegate: UnitsCellDelegate?
    var type: CellType? {
        didSet {
            label.text = type?.titleString()
        }
    }
}

final class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pushNotificationsSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchValueChanged(value: pushNotificationsSwitch.isOn)
    }
    
    var delegate: SwitchCellDelegate?
    var type: CellType? {
        didSet {
            label.text = type?.titleString()
        }
    }
}
