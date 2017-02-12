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

final class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SettingsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
