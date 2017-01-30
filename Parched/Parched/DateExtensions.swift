//
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import Foundation

extension Date {
    var timeString: String? {
        guard case self = self else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter.string(from: self)
    }
}
