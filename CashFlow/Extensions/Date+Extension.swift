//
//  Date+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation

extension Date {

    func toString(_ format: DateFormatType) -> String {
        let formatter = DateFormatter.dateFormatterShow
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }

    func toFormat(_ format: DateFormatType) -> Date? {
        toString(format).toDate(format)
    }
}
