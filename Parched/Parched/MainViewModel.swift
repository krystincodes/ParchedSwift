//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

class MainViewModel {
    var settingsViewModel: SettingsViewModel
    
    var hasSetupDefaults: Bool {
        return settingsViewModel.hasSetupDefaults
    }

    var startTimeString: String {
        return settingsViewModel.startTime?.timeString ?? "Add"
    }
    
    var endTimeString: String {
        return settingsViewModel.endTime?.timeString ?? "Add"
    }
    
    
    public init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
    }
    
    // MARK: UserDefaults methods
//    func saveContainerSizeIfValid(_ containerSize: String) -> Bool {
//        guard let containerSize = Int(containerSize) , containerSize > 0 else {
//            showErrorAlert("", message: "Container size can't be 0. If you're drinking air, there's probably another app for that.")
//            return false
//        }
//        
//        let dailyAmount = defaultsManager.dailyAmount
//        if dailyAmount > containerSize {
//            defaultsManager.containerSize = containerSize
//            return true
//        } else {
//            showErrorAlert("Oops", message: "Your container is larger than your daily amount. If I tried to do that math I'd crash. Try again.")
//            return false
//        }
//    }
}
