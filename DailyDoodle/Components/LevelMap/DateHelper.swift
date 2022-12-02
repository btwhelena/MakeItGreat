//
//  DateHelper.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 25/11/22.
//

import Foundation

class DateHelper {
    static let calendar = Calendar.current

    static func getCurrentDay() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dayString = dateFormatter.string(from: date)
        return Int(dayString)!
    }

    static func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
}
