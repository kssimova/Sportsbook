//
//  DateExtension.swift
//  SportsBook
//
//  Created by Kristina Simova on 14.03.24.
//

import UIKit

/**
 *  Extension to provide additional functionality to Date objects.
 */
extension Date {
    
    /**
     *  Returns the start of the day for the current Date instance.
     *
     *  - Parameter calendar: The calendar to use for determining the start of the day. Defaults to the current calendar.
     *  - Returns: The Date object representing the start of the day.
     */
    func startOfDay(calendar: Calendar = .current) -> Date {
        return calendar.startOfDay(for: self)
    }
}
