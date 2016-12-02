//
//  DateExtensions.swift
//  Parched
//
//  Created by Krystin Stutesman on 11/27/16.
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
