//
//  Date+Extensions.swift
//  vocard
//
//  Created by windowcow on 12/1/23.
//

import Foundation

extension Date {
    func getYearMonthDayWeekDayDateComponent() -> DateComponents {
        return Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day, .weekday], from: self)
    }
}
