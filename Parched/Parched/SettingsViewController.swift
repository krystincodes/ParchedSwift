//
//  Copyright © 2017 Krystin Stutesman. All rights reserved.
//

import UIKit

// MARK: Delegates for tableViewCells
protocol AmountCellDelegate: class {
    func amountUpdated(amount: Int, type: CellType)
}

protocol TimeCellDelegate: class {
    func timeButtonTapped(type: CellType)
    func timeChanged(time: Date, type: CellType)
}

protocol UnitsCellDelegate: class {
    func unitsChanged(value: Int)
}

protocol SwitchCellDelegate: class {
    func switchValueChanged(value: Bool)
}

final class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
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
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .containerSize:
            let cell = tableView.dequeueReusableCell(withIdentifier: "amountCell") as! AmountTableViewCell
            cell.type = cellType
            
            return cell
        case .dailyGoal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "amountCell") as! AmountTableViewCell
            cell.type = cellType
            
            return cell
        case .startTime:
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell") as! TimeTableViewCell
            cell.type = cellType
            
            return cell
        case .endTime:
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell") as! TimeTableViewCell
            cell.type = cellType
            
            return cell
        case .units:
            let cell = tableView.dequeueReusableCell(withIdentifier: "unitsCell") as! UnitsTableViewCell
            cell.type = cellType
            
            return cell
        case .pushSettings:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.type = cellType
            
            return cell
        }
        
    }
}

// MARK: UITableViewCellDelegates
extension SettingsViewController: AmountCellDelegate {
    
    internal func amountUpdated(amount: Int, type: CellType) {
        if type == .containerSize {
            viewModel?.containerSize = amount
        } else if type == .dailyGoal {
            viewModel?.dailyGoal = amount
        }
    }
    
}
