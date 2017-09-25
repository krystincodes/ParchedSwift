//
//  Copyright © 2016 Ryan Stutesman. All rights reserved.
//

import Foundation

extension Date {
    var timeString: String? {
        guard case self = self else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: self)
    }
    
    var periodString: String? {
        guard case self = self else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter.string(from: self)
    }

}
