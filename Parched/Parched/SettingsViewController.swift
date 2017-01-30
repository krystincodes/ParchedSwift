//
//  Copyright © 2017 Krystin Stutesman. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SettingsViewController {
    private enum CellType {
        case containerSize, dailyGoal, startTime, endTime, units, pushNotification
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
