//
//  Date+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation

extension Date {

    var day: Int {
        Calendar.baseCalendar.dateComponents([.day], from: self).day ?? 0
    }

    func toString(_ format: DateFormatType) -> String {
        let formatter = DateFormatter.dateFormatterShow
        formatter.dateFormat = format.rawValue
        return  formatter.string(from: self)
    }

    func toFormat(_ format: DateFormatType) -> Date? {
        toString(format).toDate(format)
    }

    func dayWihSuffix() -> String {
        switch day {
        case 1, 21, 31:
            return "\(day)st"
        case 2, 22:
            return "\(day)nd"
        case 3, 23:
            return "\(day)rd"
        default:
            return "\(day)th"
        }
    }
}
